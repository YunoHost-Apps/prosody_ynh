#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

app=prosody
config_path=/etc/prosody

_configure_prosody() {

    turn_password=$(ynh_app_setting_get --app="coturn" --key=turnserver_pwd)
    turn_external_port=$(ynh_app_setting_get --app="coturn" --key=port_turnserver_tls)

    ynh_print_info "Adding prosody configuration files..."

    # Add 00.cfg.lua, needed to customize some settings acrros all prosody vhosts
    ynh_config_add --template="00.cfg.lua" --destination="/etc/prosody/conf.avail/00.cfg.lua"
    ln -srf /etc/prosody/conf.avail/00.cfg.lua /etc/prosody/conf.d/

    # Add domain configuration
    ynh_config_add --template="domain.tpl.cfg.lua" --destination="/etc/prosody/conf.avail/${domain}.cfg.lua"
    ln -srf /etc/prosody/conf.avail/${domain}.cfg.lua /etc/prosody/conf.d/

    # Add content for /.well-known/host-meta (XEP-0156: Discovering Alternative XMPP Connection Methods)
    ynh_print_info "Creating content for \"/.well-known/host-meta\""
    ynh_config_add --template="nginx_well-known_host-meta.xml" --destination="/var/www/.well-known/${domain}/host-meta"
    chmod 644 /var/www/.well-known/${domain}/host-meta

    # Add nginx config for xmpp subdomains
    ynh_print_info "Configuring Nginx for extra domains (muc, pubsub, xmpp-upload, ...) and extra URLs (bosh, websocket)..."
    ynh_config_add --template="nginx_prosody.conf" --destination="/etc/nginx/conf.d/${domain}.d/prosody.conf"

    cp -R "../conf/hook_conf_regen" "/usr/share/yunohost/hooks/conf_regen/98-nginx_$app"
    YNH_HELPERS_VERSION=1 yunohost tools regen-conf nginx

    # Create directory for file sharing uploads
    ynh_print_info "Setting up http upload folder..."

    mkdir -p "/var/xmpp-upload/${domain}/upload"
    chown -R prosody:www-data /var/xmpp-upload/
    chmod -R g+s /var/xmpp-upload/
}

_setup_initial_app_permissions() {
    # Before fixing issue #55 (https://github.com/YunoHost-Apps/prosody_ynh/issues/55) all
    # yunohost users were allowed to use prosody, regardless of actual yunohost permissions.
    # This workaround ensures that the permission mechanism is now really in use, even when
    # upgrading from an older version of the app.

    local verbosity=${1:-verbose}

    if [ "$(yunohost app setting prosody _is_workaround_for_missing_permissions_already_applied)" != "yes" ] ; then
        test "${verbosity}" != "quiet" && ynh_print_warn "Applying workaround for missing yunohost permissions..."

        yunohost user permission add prosody all_users

        test "${verbosity}" != "quiet" && ynh_print_warn "From now on, only yunohost users with 'prosody' permission can use this service."
        test "${verbosity}" != "quiet" && ynh_print_warn "Right now, this includes **all** valid yunohost users. You may customize this if you want."

        # Prevent applying this workaround again in the future
        yunohost app setting prosody _is_workaround_for_missing_permissions_already_applied -v yes
    fi
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
