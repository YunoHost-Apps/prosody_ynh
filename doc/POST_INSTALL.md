To be able to effectively use Prosody / your XMPP server, you need:
- to expose ports 5222, 5223, 5269, 5349, 5350. You probably don't need to do anything if your server is a VPS, but if you are self-hosting at home, you need [to configure port-forwarding](https://yunohost.org/isp_box_config) on your internet router like you probably already did for port 80, 443, etc.
- for the MUC/chatrooms and file upload features to be functional, you need to force-regenerate the certificate for `__DOMAIN__` after configuring the DNS records, by running `yunohost domain cert renew __DOMAIN__`.
