In oder to have a successfull installation of the Prosody XMPP server, you shall ensure before:
- to have the following DNS records (they are also part of the recommended YunoHost configuration for `__DOMAIN__`):

```text
_xmpp-client._tcp 3600 IN SRV 0 5 5222 __DOMAIN__.
_xmpp-server._tcp 3600 IN SRV 0 5 5269 __DOMAIN__.
muc 3600 IN CNAME __DOMAIN__.
xmpp-upload 3600 IN CNAME __DOMAIN__.
pubsub 3600 IN CNAME __DOMAIN__.
```
- to *not* have manually created in YunoHost the subdomains `muc.`, `xmpp-upload.` or `pubsub.`.
