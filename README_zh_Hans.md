<!--
注意：此 README 由 <https://github.com/YunoHost/apps/tree/master/tools/readme_generator> 自动生成
请勿手动编辑。
-->

# YunoHost 上的 Prosody

[![集成程度](https://apps.yunohost.org/badge/integration/prosody)](https://ci-apps.yunohost.org/ci/apps/prosody/)
![工作状态](https://apps.yunohost.org/badge/state/prosody)
![维护状态](https://apps.yunohost.org/badge/maintained/prosody)

[![使用 YunoHost 安装 Prosody](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=prosody)

*[阅读此 README 的其它语言版本。](./ALL_README.md)*

> *通过此软件包，您可以在 YunoHost 服务器上快速、简单地安装 Prosody。*  
> *如果您还没有 YunoHost，请参阅[指南](https://yunohost.org/install)了解如何安装它。*

## 概况

Prosody is a modern XMPP communication server. It aims to be easy to set up and configure, and efficient with system resources. Additionally, for developers it aims to be easy to extend and give a flexible system on which to rapidly develop added functionality, or prototype new protocols.

🚀 Target is to provide at least:
  * A/V calls (https://github.com/YunoHost/issues/issues/1607) 
  * BOSH (https://forum.yunohost.org/t/unable-to-set-up-bosh-conf-nginx/12995)
  * invite links (if not covered by https://github.com/YunoHost/issues/issues/1677)
  * File sharing for all usual filetypes (https://forum.yunohost.org/t/metronome-mime-types-for-metronome-again/20073)

...and ultimately an Advanced Server compliance level (https://xmpp.org/extensions/xep-0479.html).

✅ What works:
  * install on Yunohost 12
  * LDAP auth
  * A/V calls
  * File upload
  * MUC
  * optional import of rosters, MUCs, bookmarks from Metronome (integrated service on Yunohost 11 or app on Yunohost 12) (pep is not supported, #12)
  * automatically install coturn if not yet present (https://github.com/anubister/coturn_ynh/ , a fork compatible with Yunohost 12)
  * XEP-0163, XEP-0191, XEP-0215, XEP-0237, XEP-0280, XEP-0313, XEP-0363 (see 'xmpp_compliance' file), XEP-0421 TBC

🐞 What does not work:
  * vjud (Users directory) (help welcomed!)

🙋 TODO (help welcomed!):
  * if applicable manage migration from upstream version of coturn app
  * usability by other apps:
    * [PeerTube](https://github.com/YunoHost-Apps/peertube_ynh): to be tested
    * [Movim](https://github.com/YunoHost-Apps/movim_ynh): app broken?
    * [Converse.js](https://github.com/YunoHost-Apps/converse_ynh): seems to work
    * [Jitsi](https://github.com/YunoHost-Apps/jitsi_ynh): to be tested
    * [Nextcloud](https://github.com/YunoHost-Apps/nextcloud_ynh): to be tested
    * [Libervia](https://salut-a-toi.org/): to be tested [non-working app](https://github.com/YunoHost-Apps/sat_ynh)
    * [biboumi](https://github.com/YunoHost-Apps/biboumi_ynh): currently [not working](https://github.com/YunoHost-Apps/biboumi_ynh/issues/29)
    * ...?
  * check initial configuration (DNS, ?) : inform or block?
  * update scripts/remove and others...
  * check/improve app score

# READ before install!
Ideally all the README :) but this in particular:
* You must ensure that your DNS configuration includes the subdomains `muc.`, `xmpp-upload.` and `pubsub.`
* You should **not** create Yunohost subdomains `muc.`, `xmpp-upload.` and `pubsub.`
* (to be confirmed) You must apply the workaround for this bug : https://github.com/anubister/prosody_ynh/issues/4#issuecomment-2318658501
* You have to deinstall Metronome app before to install this app (using the same ports).

# Additionnal infos
* Users connect on XMPP with their email address. Ensure in the Yunohost Users configuration panel they have an email address matching the domain on which you install Prosody. If not add an email alias.


💬 Further discussions, support on xmpp:yunohost-xmpp@muc.chapril.org?join
Or in the [forum](https://forum.yunohost.org/c/apps/11).

ℹ️  About this branch
This package / branch installs from the Debian packages repository `prosody` and `prosody-modules` (no compilation on server-side).
It installs on your desired (sub)domain selected during the installation.




**分发版本：** 0.12.4~ynh101
## 文档与资源

- 官方应用网站： <https://prosody.im/>
- 官方管理文档： <https://prosody.im/doc>
- 上游应用代码库： <https://hg.prosody.im/>
- YunoHost 商店： <https://apps.yunohost.org/app/prosody>
- 报告 bug： <https://github.com/YunoHost-Apps/prosody_ynh/issues>

## 开发者信息

请向 [`testing` 分支](https://github.com/YunoHost-Apps/prosody_ynh/tree/testing) 发送拉取请求。

如要尝试 `testing` 分支，请这样操作：

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/prosody_ynh/tree/testing --debug
或
sudo yunohost app upgrade prosody -u https://github.com/YunoHost-Apps/prosody_ynh/tree/testing --debug
```

**有关应用打包的更多信息：** <https://yunohost.org/packaging_apps>
