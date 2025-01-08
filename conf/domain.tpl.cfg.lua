VirtualHost "__DOMAIN__"
  enable = true
  ssl = {
        key = "/etc/yunohost/certs/__DOMAIN__/key.pem";
        certificate = "/etc/yunohost/certs/__DOMAIN__/crt.pem";
  }
  authentication = "ldap"
  ldap_base = "ou=users,dc=yunohost,dc=org"
  ldap = {
     hostname      = "localhost",
     user = {
       basedn        = "ou=users,dc=yunohost,dc=org",
       filter        = "(&(objectClass=posixAccount)(mail=*@__DOMAIN__)(permission=cn=xmpp.main,ou=permission,dc=yunohost,dc=org))",
       usernamefield = "mail",
       namefield     = "cn",
       },
  }

  modules_enabled = {
    "mam";
  }

  -- Discovery items
  disco_items = {
    { "muc.__DOMAIN__" },
    { "pubsub.__DOMAIN__" },
    --{ "jabber.__DOMAIN__" },
    --{ "vjud.__DOMAIN__" },
    { "xmpp-upload.__DOMAIN__" },
  };

  -- Set up A/V calls
  turn_external_secret = "__TURN_PASSWORD__"
  turn_external_host = "__DOMAIN__"
  turn_external_port = __TURN_EXTERNAL_PORT__

--  contact_info = {
--    abuse = { "mailto:abuse@__DOMAIN__", "xmpp:admin@__DOMAIN__" };
--    admin = { "mailto:root@__DOMAIN__", "xmpp:admin@__DOMAIN__" };
--  };

------ Components ------
-- You can specify components to add hosts that provide special services,
-- like multi-user conferences, and transports.

---Set up a MUC (multi-user chat) room server
Component "muc.__DOMAIN__" "muc"
  name = "__DOMAIN__ Chatrooms"

  modules_enabled = {
    --"muc_limits";
    "muc_log";
    --"muc_log_mam";
    --"muc_log_http";
    "vcard_muc";
    "muc_mam";
  }

  muc_event_rate = 0.5
  muc_burst_factor = 10
  room_default_config = {
    logging = true,
    persistent = true
  };

  muc_log_expires_after = "1w"

---Set up a PubSub server
Component "pubsub.__DOMAIN__" "pubsub"
  name = "__DOMAIN__ Publish/Subscribe"

  unrestricted_node_creation = true -- Anyone can create a PubSub node (from any server)

---Set up a HTTP Upload service
Component "xmpp-upload.__DOMAIN__" "http_upload"
  name = "__DOMAIN__ Sharing Service"
  http_upload_path = "/var/xmpp-upload/__DOMAIN__/upload/"
  http_external_url = "https://xmpp-upload.__DOMAIN__"
  --http_file_base_path = "/upload"
  --http_file_size_limit = 50*1024*1024
  --http_file_quota = 50*1024*1024
  http_upload_file_size_limit = 50 * 1024 * 1024 -- bytes (limited by http_max_content_size (default 10M))
  http_upload_quota = 1 * 1024 * 1024 * 1024 -- bytes
  http_upload_expire_after = 60 * 60 * 24 * 7 -- a week in seconds

---Set up a VJUD service
--FIXME: vjud does not load even if vcard is installed/enabled
--Component "vjud.__DOMAIN__" "vjud"
--  vjud_disco_name = "__DOMAIN__ User Directory"
