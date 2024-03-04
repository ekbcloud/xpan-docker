<h1 align="center">
    <img src="https://raw.githubusercontent.com/ekbcloud/xpan-docker/main/images/logo.png" width="100"/>
  <br>
  丰盘ECM
</h1>
<h4 align="center">企业级私有文档协同管理系统 v24.1 </h4>

> **一句话介绍下丰盘ECM软件**
>
> 丰盘ECM（ [访问产品官网](https://www.ekbcloud.com/) ）是一款ECM类软件 (Enterprise Content Management 企业内容管理)，一款聚焦 **企业内部文档协同管理需求、支持私有化部署并且可长期免费使用** 的私有文档管理系统，提供与腾讯微盘、阿里云盘类似的产品体验，帮助企业在内网环境打造一体化的文档共享平台，**沉淀核心知识资产，提升知识流通效率，降低数据泄露风险**。

## :dart: 最新版 v24.1

本次商业版更新（[查看价格计划](https://www.ekbcloud.com/pricing)）主要加入**企业对外分享功能插件**，允许员工创建企业外部用户可访问的互联网链接，无需内部账号。企业IT管理员可配置专用的外网流量端口，将系统的互联网访问流量与内网账号的日常流量进行物理隔离，彻底隔绝了互联网用户直接访问内网系统接口的安全隐患，极大提升了网盘系统的安全性。

本次社区版更新主要加入了**批量添加用户的功能**，空间管理员不再需要逐个添加用户到本空间，可以一次**批量添加部门用户至本空间**，大大提升操作效率。其他优化项及问题修复列表如下：

- 优化了顶部空间导航，切换文档空间更加顺畅；
- 屏蔽了搜索引擎爬虫自动收录的问题，提升系统安全性；
- 修复了LDAP/AD模块对于服务器完全禁用匿名访问时的连接探测错误；
- 修复了删除子目录权限后影响根目录权限的问题；
- 升级并加固了流量网关的安全性；

## :sparkles: 产品优势

国内互联网三巨头的办公协同平台钉钉、企微、飞书都提供了很不错的网盘或云文档产品，但产品与平台紧密集成，无法实现私有部署，或者私有部署的费用非常昂贵，多数企业无力承担。对于重视数据安全、不希望把核心数据托管在第三方互联网平台的企业来说，支持私有化部署仍旧是他们选型网盘类产品的必要条件。而国内提供私有化部署的面向企业的网盘产品，多数不提供免费版本。国外对标Dropbox的ownCloud/Nextcloud开源产品虽然支持私有化部署，但在企业权限管理和协作功能上不太符合国内企业用户的工作方式和使用习惯，更多被用于个人网盘或者小团队的协作。

丰盘ECM产品正是为了弥补这样的市场空缺应运而生。丰盘ECM只做企业客户，只做私有部署，商业模式上采取国外企业级软件主流的Freemium模式，即**社区版永久免费+商业版付费增值插件**，其中社区版 **不限人数、不限容量、永久免费**，满足企业的最基础的文档管理诉求，可用于替代传统Windows共享、FTP或者SVN的作用；商业版通过插件市场，提供差异化的付费增值功能，满足企业高阶的需求。

与国外同类开源产品相比，丰盘ECM在权限管控方面更为精细化，适合不同规模的团队的协作管理需求；同时，产品在整体界面设计和交互体验上更符合国人的操作习惯。

丰盘ECM代码尚未开源，我们将在未来商业化进展到合适的时机开放我们的产品底座源代码，通过商业增值插件计费，欢迎关注⭐

**快捷链接：**

- [立即安装部署体验](https://www.ekbcloud.com/docs/admin_manual/setup.html)
- [查看产品帮助手册](https://www.ekbcloud.com/docs/)
- [关注行业产品最新动态](https://www.ekbcloud.com/blog/)
- [了解商业版差异及报价](https://www.ekbcloud.com/pricing)

## :gem: 功能速览

### 随时随地与您的同事共享内部文档

通过集中式的文档系统部署，企业资料不用分散在每个部门、每位员工的手里。 员工现在可以随时随地通过手机、平板和电脑安全地访问企业最新资料， 并与其他同事实时分享在线文档的最新版本，再也不必低效、不安全的将内部资料在聊天软件里传来传去了。

![image](https://github.com/ekbcloud/xpan-docker/assets/77321546/b7c68954-ec67-4275-872e-c720b9565b04)

### 百余种文件格式的在线预览

无需下载，支持PDF/Word/Excel/PPT等主流Office办公文档，以及图片/视频/文本/代码文件等百余种文件格式的在线预览， 大大降低了因员工下载&传输资料导致的安全泄密事故。

![image](https://github.com/ekbcloud/xpan-docker/assets/77321546/beb71687-f253-43a7-b18c-083d99284a59)

### AD/LDAP/企微/钉钉集成身份认证

支持对接Windows域控（ Active Directory）和 OpenLDAP 身份认证协议；与国内主流的腾讯企业微信和阿里钉钉平台实现一站式集成，打通账号体系，实现扫码免密登录， 大大简化了企业账号管理的负担；工作台入口页面无缝集成，用户操作体验更佳；微盘/钉盘的私有替代版；

![image](https://github.com/ekbcloud/xpan-docker/assets/77321546/6fbfbed5-a1a6-4d46-901f-b0214ca5f943)

### 创建具有时效性的临时分享链接

一键开启资料的即时分享，无需复杂权限配置；逾期自动失效，零管理成本； 可创建仅限局域网使用的私有链接，也可通过专用端口隔离技术，发布互联网安全访问链接， 与企业外的合作伙伴或客户共享资料，无需内部账号。

![image](https://github.com/ekbcloud/xpan-docker/assets/77321546/fee88307-5ac0-44ea-a466-7f5516d87385)
