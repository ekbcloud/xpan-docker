<h1 align="center">
    <img src="https://raw.githubusercontent.com/ekbcloud/xpan-docker/main/images/logo.png" width="100"/>
  <br>
  丰盘ECM
</h1>
<h4 align="center">企业级私有文档协同管理系统 v25.3 </h4>

> **一句话介绍下丰盘ECM软件**
>
> 丰盘ECM（ [访问产品官网](https://www.ekbcloud.com/) ）是一款ECM类软件 (Enterprise Content Management 企业内容管理)，一款聚焦 **企业内部文档协同管理需求、支持私有化部署并且可长期免费使用** 的私有文档管理系统，提供与腾讯微盘、阿里云盘类似的产品体验，帮助企业在内网环境打造一体化的文档共享平台，**沉淀核心知识资产，提升知识流通效率，降低数据泄露风险**。

## :dart: 最新版 v25.3 (发布于2025年3月)

本次商业版更新（[查看价格计划](https://www.ekbcloud.com/pricing)）主要加入「三维模型专业格式在线预览」的新插件，支持STL/OBJ/IGS等十几种三维模型专业格式的跨设备终端在线预览，减少因下载设计稿而导致资料泄露的安全风险。

我们还推出了桌面客户端，对于无法在浏览器里直接预览的文件格式来说，桌面客户端可以直接调用用户本地默认软件应用打开文档，体验更加友好，同时还支持使用本地软件编辑保存后直接上传新版本至网盘，操作更加高效便捷。桌面客户端目前优先开放给商业版客户体验，后续会开放给社区版客户。

本次版本更新对许可证授权机制做了调整，当许可证到期不做续期或者付费续订，系统不再限制登录及使用，而是降级为「只读实例」，用户仍可登录并继续使用我们的软件查阅并下载资料，使用绝大多数功能，相当于永久只读授权模式，但像文件上传、账号创建等部分变更操作将被限制。此调整原本在v24.8版本里只针对商业版长订阅客户开放，在v25.3版本里我们面向全体客户无条件开放。

其他优化项及问题修复列表如下：

- 优化企微钉钉因网络连接不稳定导致的服务器请求问题；
- 修复钉钉客户端认证跳转报错的问题；
- 修复关闭分享报错的问题；
- 修复部门列表等排版错位的体验问题；
- 修复移动端没有加载个性化主题配置信息的问题；
- 修复移动端分享页面报错的问题；
  
## :sparkles: 为什么选择丰盘？

国内互联网三巨头的办公协同平台钉钉、企微、飞书都提供了很不错的网盘或云文档产品，但产品与平台紧密集成，无法实现私有部署，或者私有部署的费用非常昂贵，多数企业无力承担。对于重视数据安全、不希望把核心数据托管在第三方互联网平台的企业来说，支持私有化部署仍旧是他们选型网盘类产品的必要条件。而国内提供私有化部署的面向企业的网盘产品，多数不提供免费版本。国外对标Dropbox的ownCloud/Nextcloud开源产品虽然支持私有化部署，但在企业权限管理和协作功能上不太符合国内企业用户的工作方式和使用习惯，更多被用于个人网盘或者小团队的协作。

丰盘ECM源自我们十几年从事大型国企央企信息化项目的实践发展而来的产品，产品围绕着企业客户的日常协作场景进行针对性的设计。丰盘ECM专注私有部署，不提供公共网盘服务；商业模式上采用了国外成熟企业软件厂商普遍使用的Freemium模式，即**社区版永久免费+商业版付费增值插件**，其中 **社区版不限用户数、不限使用时长、永久免费**，满足企业最基础的文档管理诉求，可用于替代传统Windows SMB共享、FTP服务器或者SVN版本管理工具的作用；商业版通过插件市场，提供差异化的付费增值功能，满足企业高阶的需求。与国外同类开源产品相比，丰盘ECM在权限管控方面更为精细化，适合不同规模的团队的协作管理需求；同时，产品在整体界面设计和交互体验上更符合国人的操作习惯。自2020年推出永久免费版本至今，社区版功能仍在持续增强，而已有的免费功能也从未转换为商业付费功能，很好保持了免费与商业化的平衡。

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

无需下载，支持PDF/Word/Excel/PPT等主流Office办公文档以及图片/视频/文本/代码文件等百余种文件格式的在线预览；支持STL/OBJ/IGS等十几种三维模型专业格式的在线预览；极大降低了因员工下载资料导致的安全泄密事故。

![image](https://github.com/ekbcloud/xpan-docker/assets/77321546/beb71687-f253-43a7-b18c-083d99284a59)

### AD/LDAP/企微/钉钉/SSO单点登录

支持对接Windows域控（ Active Directory）和 OpenLDAP 身份认证协议；支持接入泛微/蓝凌/致远等内网OA平台的OAuth2账号认证体系，大大简化了企业账号管理的负担；与国内主流的腾讯企业微信、钉钉实现一站式集成，打通账号体系，实现扫码免密登录， 工作台入口页面无缝集成，用户操作体验更佳；微盘/钉盘的私有替代版；

![image](https://github.com/ekbcloud/xpan-docker/assets/77321546/6fbfbed5-a1a6-4d46-901f-b0214ca5f943)

### 创建具有时效性的临时分享链接

一键开启资料的即时分享，无需复杂权限配置；逾期自动失效，零管理成本； 可创建仅限局域网使用的私有链接，也可通过专用端口隔离技术，发布互联网安全访问链接， 与企业外的合作伙伴或客户共享资料，无需创建账号，密码或邮箱验证登录。

![image](https://github.com/ekbcloud/xpan-docker/assets/77321546/fee88307-5ac0-44ea-a466-7f5516d87385)
