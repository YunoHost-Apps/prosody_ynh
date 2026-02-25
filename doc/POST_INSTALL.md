To be able to effectively use Prosody / your XMPP server, you need:
- to expose ports 5222, 5223, 5269, 5349, 5350. You probably don't need to do anything if your server is a VPS, but if you are self-hosting at home, you need [to configure port-forwarding](https://yunohost.org/isp_box_config) on your internet router like you probably already did for port 80, 443, etc.
- for the MUC/chatrooms and file upload features to be functional, you need to force-regenerate the certificate for `__DOMAIN__` after configuring the DNS records, by running `yunohost domain cert renew __DOMAIN__`.

If you want to use Prosody as a [UnifiedPush distributor](https://unifiedpush.org/), you can configure it, following the [Prosody documentation](https://modules.prosody.im/mod_unified_push):
- install the module `mod_unified_push` as root: `prosodyctl install --server=https://modules.prosody.im/rocks/ mod_unified_push`
- edit your Prosody configuration at `/etc/prosody/conf.d/__DOMAIN__.cfg.lua`. Add the module in the `modules_enabled` list:
```
  modules_enabled = {
    -- ...
    "unified_push";
    -- ...
  }
```
- you also need to redirect the `/push` path to Prosody. Add the path in the `http_paths` list:
```
  http_paths = {
    -- ...
    unified_push = "/push";
    -- ...
  }
```
- reload the Prosody configuration: `systemctl reload prosody`
