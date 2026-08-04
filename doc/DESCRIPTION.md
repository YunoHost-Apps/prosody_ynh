Prosody is a modern and lightweight XMPP communication server.

To use Prosody / XMPP, you will also need a client.
There are a [lot of XMPP clients](https://xmpp.org/software/?category=clients) available out there, but here are some recommendations, depending on your device, platform and preferences:

- [Conversations](https://conversations.im/) - Android
- [Movim](https://movim.eu) - Web - available as a YunoHost app
- [ConverseJS](https://conversejs.org) - Web - available as a YunoHost app
- [Gajim](https://gajim.org/) - Linux, Windows
- [Dino](https://dino.im) - Linux
- [Monal](https://monal-im.org/) - iOS, macOS
- [Profanity](https://profanity-im.github.io/) - Linux console
- [Poezio](https://poez.io/) - Linux console

You will be able to connect using `your_yunohost_username@domain.tld` + your password (i.e. your credentials are the same as for email, but for instant messaging)

## App conflicts/dependencies
**Conflict**
* [Metronome](https://github.com/YunoHost-Apps/metronome_ynh) : you have to deinstall Metronome app before to install this app (using the same ports)
* [Simplex](https://github.com/YunoHost-Apps/simplex_ynh) : you have to deinstall Simplex app before to install this app (using the same ports)

**Sequencing**
* [Jitsi](https://github.com/YunoHost-Apps/jitsi_ynh) : if you want to have both Jitsi and Prosody on your server, you must install first the Prosody app, then the Jitsi app

**Dependencies**
* [coturn](https://github.com/YunoHost-Apps/jitsi_ynh) : it will be automatically installed if needed


# Additionnal infos
* Users connect on XMPP with their email address. Ensure in the Yunohost Users configuration panel they have an email address matching the domain on which you install Prosody. If not add an email alias.

🙋 TODO (help welcomed!):
  * usability by other apps:
    * [PeerTube](https://github.com/YunoHost-Apps/peertube_ynh): to be tested
    * [Converse.js](https://github.com/YunoHost-Apps/converse_ynh): seems to work 🥳
    * [Jitsi](https://github.com/YunoHost-Apps/jitsi_ynh): reported [to work](https://forum.yunohost.org/t/jitsi-install-fails-with-prosody-testing/35879) 🥳 
    * [Nextcloud](https://github.com/YunoHost-Apps/nextcloud_ynh): to be tested
    * [Libervia](https://salut-a-toi.org/): to be tested [non-working app](https://github.com/YunoHost-Apps/sat_ynh)
    * ...?
  * check initial configuration (DNS, ?) : information via PRE_INSTALL.md

💬 Further discussions, support on [yunohost-xmpp@muc.chapril.org](xmpp:yunohost-xmpp@muc.chapril.org?join)
Or in the [forum](https://forum.yunohost.org/c/apps/11).
