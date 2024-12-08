<!--
Este archivo README esta generado automaticamente<https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
No se debe editar a mano.
-->

# Prosody para Yunohost

[![Nivel de integración](https://apps.yunohost.org/badge/integration/prosody)](https://ci-apps.yunohost.org/ci/apps/prosody/)
![Estado funcional](https://apps.yunohost.org/badge/state/prosody)
![Estado En Mantención](https://apps.yunohost.org/badge/maintained/prosody)

[![Instalar Prosody con Yunhost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=prosody)

*[Leer este README en otros idiomas.](./ALL_README.md)*

> *Este paquete le permite instalarProsody rapidamente y simplement en un servidor YunoHost.*  
> *Si no tiene YunoHost, visita [the guide](https://yunohost.org/install) para aprender como instalarla.*

## Descripción general

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
    * ...?
  * check initial configuration (DNS, ?) : inform or block?
  * update scripts/remove and others...
  * check/improve app score

# READ before install!
Ideally all the README :) but this in particular:
* You must ensure that your DNS configuration includes the subdomains `muc.` and `xmpp-upload.`
* You should **not** create Yunohost subdomains `muc.` and `xmpp-upload.`
* (to be confirmed) You must apply the workaround for this bug : https://github.com/anubister/prosody_ynh/issues/4#issuecomment-2318658501
* You have to deinstall Metronome app before to install this app (using the same ports).

# Additionnal infos
* Users connect on XMPP with their email address. Ensure in the Yunohost Users configuration panel they have an email address matching the domain on which you install Prosody. If not add an email alias.


💬 Further discussions, support on xmpp:yunohost-xmpp@muc.chapril.org?join
Or in the [forum](https://forum.yunohost.org/c/apps/11).

ℹ️  About this branch
This package / branch installs from the Debian packages repository `prosody` and `prosody-modules` (no compilation on server-side).
It installs on your desired (sub)domain selected during the installation.




**Versión actual:** 0.12.4~ynh100
## Documentaciones y recursos

- Sitio web oficial: <https://prosody.im/>
- Documentación administrador oficial: <https://prosody.im/doc>
- Repositorio del código fuente oficial de la aplicación : <https://hg.prosody.im/>
- Catálogo YunoHost: <https://apps.yunohost.org/app/prosody>
- Reportar un error: <https://github.com/YunoHost-Apps/prosody_ynh/issues>

## Información para desarrolladores

Por favor enviar sus correcciones a la [rama `testing`](https://github.com/YunoHost-Apps/prosody_ynh/tree/testing).

Para probar la rama `testing`, sigue asÍ:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/prosody_ynh/tree/testing --debug
o
sudo yunohost app upgrade prosody -u https://github.com/YunoHost-Apps/prosody_ynh/tree/testing --debug
```

**Mas informaciones sobre el empaquetado de aplicaciones:** <https://yunohost.org/packaging_apps>
