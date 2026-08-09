VirtualHost "__DOMAIN__"
  enable = true
  ssl = {
        key = "/etc/yunohost/certs/__DOMAIN__/key.pem";
        certificate = "/etc/yunohost/certs/__DOMAIN__/crt.pem";
  }
  authentication = "ldap"
  ldap_base = "ou=users,dc=yunohost,dc=org"
  ldap_filter = "(&(|(mail=$user@$host)(uid=$user))(permission=cn=__APP__.main,ou=permission,dc=yunohost,dc=org))"

  modules_enabled = {
    "mam";
    "cloud_notify";
    "smacks";
    "turn_external";
    "bosh";
    "websocket";
    "csi_battery_saver";
    "server_contact_info"; -- XEP-0157: advertise abuse/admin contacts
    "pubsub_serverinfo";   -- XEP-0485: publish server info via pubsub
    "sasl_ssdp";           -- XEP-0474: SASL SCRAM downgrade protection
  }

  modules_disabled = {
    "register";
    "csi_simple"; -- Replaced by "csi_battery_saver"
  }

  -- Discovery items
  disco_items = {
    { "muc.__DOMAIN__" },
    { "pubsub.__DOMAIN__" },
    { "proxy.__DOMAIN__" },
    --{ "jabber.__DOMAIN__" },
    --{ "vjud.__DOMAIN__" },
    { "xmpp-upload.__DOMAIN__" },
  };

  -- Set up A/V calls
  turn_external_secret = "__TURN_PASSWORD__"
  turn_external_host = "__DOMAIN__"
  turn_external_port = __TURN_EXTERNAL_PORT__

  -- XEP-0157 server contact info. YunoHost does not provision role aliases
  -- (abuse@, postmaster@, root@) for a domain, so we never guess an address:
  -- advertise only what the admin sets via the config panel (empty = none).
  -- A Lua local, not a config setting: assigning a bare name here would set it
  -- as a Prosody option, and reading it back would go through configmanager's
  -- environment metatable rather than being a plain variable read.
  local contact = "__XMPP_CONTACT_ADDRESS__"
  if contact ~= "" then
    contact_info = {
      abuse = { contact };
      admin = { contact };
    };
  end

  http_paths = {
    bosh = "/xmpp-bosh";
  }


------ Components ------
-- You can specify components to add hosts that provide special services,
-- like multi-user conferences, and transports.

---Set up a MUC (multi-user chat) room server
Component "muc.__DOMAIN__" "muc"
  name = "__DOMAIN__ Chatrooms"

  modules_enabled = {
    --"muc_limits";
    "vcard_muc";
    "muc_mam";
  }

  muc_event_rate = 0.5
  muc_burst_factor = 10
  room_default_config = {
    logging = true,
    persistent = __ROOMS_PERSISTENT__
  };

  muc_log_expires_after = "1w"

---Set up a PubSub server
Component "pubsub.__DOMAIN__" "pubsub"
  name = "__DOMAIN__ Publish/Subscribe"

  unrestricted_node_creation = true -- Anyone can create a PubSub node (from any server)

---Set up a HTTP Upload service
Component "xmpp-upload.__DOMAIN__" "http_file_share"
  name = "__DOMAIN__ Sharing Service"
  http_external_url = "https://xmpp-upload.__DOMAIN__"
  http_file_share_size_limit = __HTTP_FILE_SHARE_SIZE_LIMIT__
  http_file_share_global_quota = __HTTP_FILE_SHARE_GLOBAL_QUOTA__
  http_file_share_expires_after = __HTTP_FILE_SHARE_EXPIRES_AFTER__

  http_paths = {
    file_share = "/upload";
  }

---Set up a SOCKS5 Bytestreams file-transfer proxy (XEP-0065)
Component "proxy.__DOMAIN__" "proxy65"
  name = "__DOMAIN__ File Transfer Proxy"
  proxy65_address = "proxy.__DOMAIN__"
