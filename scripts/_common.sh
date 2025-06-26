#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

app=prosody
config_path=/etc/prosody

_configure_prosody() {

    turn_password=$(ynh_app_setting_get --app="coturn" --key=turnserver_pwd)
    turn_external_port=$(ynh_app_setting_get --app="coturn" --key=port_turnserver_tls)

    ynh_script_progression "Adding prosody configuration files..."

    # Add 00.cfg.lua, needed to customize some settings acrros all prosody vhosts
    ynh_config_add --template="00.cfg.lua" --destination="/etc/prosody/conf.avail/00.cfg.lua"
    ln -srf /etc/prosody/conf.avail/00.cfg.lua /etc/prosody/conf.d/

    # Add domain configuration
    ynh_config_add --template="domain.tpl.cfg.lua" --destination="/etc/prosody/conf.avail/${domain}.cfg.lua"
    ln -srf /etc/prosody/conf.avail/${domain}.cfg.lua /etc/prosody/conf.d/

    # Add content for /.well-known/host-meta (XEP-0156: Discovering Alternative XMPP Connection Methods)

    ynh_config_add --template="nginx_well-known_host-meta.xml" --destination="/var/www/.well-known/${domain}/host-meta"
    chmod 644 /var/www/.well-known/${domain}/host-meta

    # Add nginx config for xmpp subdomains
    ynh_config_add --template="nginx_prosody.conf" --destination="/etc/nginx/conf.d/${domain}.d/prosody.conf"

    cp -R "../conf/hook_conf_regen" "/usr/share/yunohost/hooks/conf_regen/98-nginx_$app"
    YNH_HELPERS_VERSION=1 yunohost tools regen-conf nginx

    # Create directory for file sharing uploads

    mkdir -p "/var/xmpp-upload/${domain}/upload"
    chown -R prosody:www-data /var/xmpp-upload/
    chmod -R g+s /var/xmpp-upload/
}

#=================================================
# PERSONAL HELPERS
#=================================================

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
