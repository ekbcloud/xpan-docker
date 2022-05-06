#!/bin/bash

echo "安装脚本版本：v1.2.1+20220427" 

set -e

error=$(tput setaf 1)
warn=$(tput setaf 3)
strong=$(tput setaf 4)
process=$(tput setaf 6)
success=$(tput setaf 2)
reset=$(tput sgr0)

WORKSPACE=/opt/xpan
PGPASS_FILE=${WORKSPACE}/data/secrets/pgpass
DOCKER_REPO=ekbc
tag=stable
version=stable

collect_info (){	
	local confirm
	printf "指定网盘系统的HTTP访问端口(默认：80) "
	
	read public_port
	if [ -z $public_port ]; then	
		public_port=80
	elif [[ $public_port -lt 1 || $public_port -gt 65535 ]]; then
		printf "${error}非法端口值${reset}\n"
		exit
	fi	
	printf "将使用 ${strong}$public_port${reset} 端口对外服务，如访问不了请检查服务器或云主机的防火墙配置\n"
	
	printf "是否开启HTTPS？(y/n) "
	
	read confirm
	if [ -z $confirm ] || [ $confirm != "y" ]; then
		https=""
	else
		https="-p 443:443"
		printf "HTTPS测试域名为：${strong}https://xpan.local${reset} ，请将 ${strong}/opt/xpan/data/secrets/${reset} 目录下的 ${strong}ssl_certificate.crt${reset} 和 ${strong}ssl_certificate.key${reset} 替换为有效的目标域名证书文件。\n"
	fi
	
	timedatectl
	printf "\n\n请确认上述系统时间及时区配置是否正确\n"
	printf "时间误差太大有可能会影响系统运行，并导致网盘系统记录错误的信息\n"
	printf "${strong}请确认是否继续安装？(y/n?)${reset}"
	read confirm
	if [ -z $confirm ] || [ $confirm != "y" ]; then
		printf "退出安装!\n"
		exit
	fi

	printf "开始自动化安装环节\n如遇到网络超时、Timeout等的报错关键字，可通过再次运行本脚本重试解决${reset}\n"
}

make_folders () {
	mkdir -p ${WORKSPACE}/bin/
	mkdir -p ${WORKSPACE}/setup/
	mkdir -p ${WORKSPACE}/tools/
	mkdir -p ${WORKSPACE}/logs/gw/
	mkdir -p ${WORKSPACE}/data/files/
	mkdir -p ${WORKSPACE}/data/pgdata/
	mkdir -p ${WORKSPACE}/data/secrets/
	
	printf "工作目录 ${strong}/opt/xpan/${reset} 已创建成功，系统所有数据及日志均存储在此目录下\n"
}

install_docker () {
	local script=docker-install-20.10.sh
	# check if docker already installed.
	if [ -x "$(command -v docker)" ]; then
		printf "${strong}当前已经安装了DOCKER环境，跳过DOCKER安装环节\n${reset}"
	else
		# temporarily disable error capturing when calling external script
		set +e
		sudo bash ${WORKSPACE}/setup/${script} --mirror Aliyun
		set -e
		# add current user to DOCKER group
		sudo usermod -aG docker $USER
		# enable docker to auto start after reboot
		sudo systemctl enable docker.service
		sudo systemctl enable containerd.service
	fi
}

download_setupfile () {
	if [ -x "$(command -v wget)" ]; then
		wget https://ota.xpan.ekbcloud.com/api/v1/ota/setupfile?version=${version} -O ${WORKSPACE}/setup/~setup.tar.gz
	elif [ -x "$(command -v curl)" ]; then
		curl https://ota.xpan.ekbcloud.com/api/v1/ota/setupfile?version=${version} --output ${WORKSPACE}/setup/~setup.tar.gz
	else
		printf "${error}找不到wget或curl命令，请手动下载 https://ota.xpan.ekbcloud.com/api/v1/ota/setupfile?version=${version}，保存至 ${WORKSPACE}/setup/~setup.tar.gz \n${reset}"
		exit
	fi
	
	sudo tar -xzf ${WORKSPACE}/setup/~setup.tar.gz -C ${WORKSPACE}/setup/
	sudo chmod u+rx,g+rx,o+rx ${WORKSPACE}/setup/*.sh
	
	mv ${WORKSPACE}/setup/ssl* ${WORKSPACE}/data/secrets/
	mv ${WORKSPACE}/setup/xpc.sh ${WORKSPACE}/tools/xpc.sh
}

pull_images () {
	printf "${process}拉取相关DOCKER镜像，产品版本标签：${tag}${reset}\n"
	docker pull ${image_gw}
	docker pull ${image_db}
	docker pull ${image_api}
	docker pull ${image_ota}
	docker pull ${image_fe}
}

install_services () {	
	pgpass=$(get_pgpwd)
	
	if [ -z "$(docker network ls | grep xpan)" ]; then
		printf "${process}正在创建系统专用虚拟网络xpan...${reset}\n"
		docker network create --driver=bridge xpan
	else		
		printf "${warn}DOCKER虚拟网络xpan已存在，跳过${reset}\n"
	fi
	
	local share_options="-d --network=xpan -v /etc/localtime:/etc/localtime:ro"
	local env="-e POSTGRES_PASSWORD=${pgpass}"
	local logs="-v ${WORKSPACE}/logs:/xpan/logs"
	local secrets="-v ${WORKSPACE}/data/secrets:/xpan/data/secrets"
	
	local status=$(check_container xpan-db)
	if [ "${status}" -eq "0" ]; then
		printf "${process}正在安装配置数据库服务...${reset}\n"
		docker run ${share_options} ${logs} ${env} -v ${WORKSPACE}/data/pgdata/:/var/lib/postgresql/data/ --name xpan-db -p 5432:5432 ${image_db} postgres -c max_prepared_transactions=64
	elif [ "${status}" -eq "-1" ]; then
		printf "${warn}数据库服务容器已存在，正在启动${reset}\n"
		docker start xpan-db
	else		
		printf "${warn}数据库服务正在运行中，自动跳过${reset}\n"
	fi

	status=$(check_container xpan-api)
	if [ "${status}" -eq "0" ]; then
		printf "${process}正在安装配置系统API服务...${reset}\n"
		docker run ${share_options} ${logs} ${env} ${secrets} -v ${WORKSPACE}/data/files/:/xpan/data/files/ --name xpan-api ${image_api}
	elif [ "${status}" -eq "-1" ]; then
		printf "${warn}系统API服务容器已存在，正在启动${reset}\n"
		docker start xpan-api
	else		
		printf "${warn}系统API服务正在运行中，自动跳过${reset}\n"
	fi
	
	status=$(check_container xpan-fe)
	if [ "${status}" -eq "0" ]; then
		printf "${process}正在安装配置系统站点服务...${reset}\n"
		docker run ${share_options} ${logs} --name xpan-fe ${image_fe}
	elif [ "${status}" -eq "-1" ]; then
		printf "${warn}系统站点服务容器已存在，正在启动${reset}\n"
		docker start xpan-fe
	else		
		printf "${warn}系统站点服务正在运行中，自动跳过${reset}\n"
	fi

	status=$(check_container xpan-ota)
	if [ "${status}" -eq "0" ]; then
		printf "${process}正在安装配置系统在线升级服务...${reset}\n"
		docker run ${share_options} ${env} ${secrets} -v ${WORKSPACE}/:/xpan/ -v /var/run/docker.sock:/var/run/docker.sock --name xpan-ota ${image_ota}
	elif [ "${status}" -eq "-1" ]; then
		printf "${warn}系统在线升级服务容器已存在，正在启动${reset}\n"
		docker start xpan-ota
	else		
		printf "${warn}系统在线升级服务正在运行中，自动跳过${reset}\n"
	fi
	
	status=$(check_container xpan-gw)
	if [ "${status}" -eq "0" ]; then
		printf "${process}正在安装配置系统网关服务...${reset}\n"
		docker run ${share_options} ${logs} -p ${public_port}:80 ${https} ${secrets} --name xpan-gw ${image_gw}
	elif [ "${status}" -eq "-1" ]; then
		printf "${warn}系统网关服务容器已存在，正在启动${reset}\n"
		docker start xpan-gw
	else		
		printf "${warn}系统网关服务正在运行中，自动跳过${reset}\n"
	fi

	printf "${process}系统安装完成\n"
	printf "PG数据库密码为：${success}${pgpass}${process}\n" 
	printf "系统超级管理员账号及临时密码：${success}sysadmin/SYSadmin!${process}\n"	
	printf "访问地址：${success}http://$(hostname):${public_port}/app/${reset}\n"
}

# return 0 if container not exists, -1 if container is stopped, 1 if container is running.
check_container () {
	if [ -n "$(docker container ls | grep " $1\$")" ]; then
		echo "1"
	elif [ -n "$(docker container ls -a | grep " $1\$")" ]; then
		echo "-1"
	else
		echo "0"
	fi
}

get_pgpwd () {
	local pwd
	if [ ! -e "${PGPASS_FILE}" ]; then
		pwd=$(tr -dc A-HJ-NP-Za-kmnp-z2-9 </dev/urandom | head -c 8)
		echo ${pwd} > ${PGPASS_FILE}
	else
		pwd=$(cat ${PGPASS_FILE})
	fi
	
	echo ${pwd}
}

root_check () {
	if [ $(id -u) != "0" ]; then
		printf "${error}脚本需要以root或sudo身份执行\n${reset}"
		exit
	fi
}

root_check

while [ $# -gt 0 ]; do
	case "$1" in
	-v|--version)
		version="$2"
		tag="p$2"
		shift 1
	;;
	*)
		printf "${error}unknown options '$1'${reset}\n"
		exit 1
	;;		
	esac
	shift 1
done

image_db=${DOCKER_REPO}/xpan-db:${tag}
image_api=${DOCKER_REPO}/xpan-api:${tag}
image_fe=${DOCKER_REPO}/xpan-fe:${tag}
image_ota=${DOCKER_REPO}/xpan-ota:${tag}
image_gw=${DOCKER_REPO}/xpan-gw:${tag}

collect_info
make_folders
download_setupfile
install_docker
pull_images
install_services
