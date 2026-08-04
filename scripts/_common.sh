#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

app=prosody
config_path=/etc/prosody

_configure_prosody() {

    turn_password=$(ynh_app_setting_get --app="coturn" --key=turnserver_pwd)
    turn_external_port=$(ynh_app_setting_get --app="coturn" --key=port_turnserver_tls)

    # Restore custom settings from config panel if any, or setup reasonable default values
    ynh_app_setting_set_default --key=http_file_share_size_limit --value="50 * 1024 * 1024"
    http_file_share_size_limit=$(ynh_app_setting_get --key=http_file_share_size_limit)

    ynh_app_setting_set_default --key=http_file_share_global_quota --value="500 * 1024 * 1024"
    http_file_share_global_quota=$(ynh_app_setting_get --key=http_file_share_global_quota)

    ynh_app_setting_set_default --key=http_file_share_expires_after --value="3 * 31 * 24 * 60 * 60"
    http_file_share_expires_after=$(ynh_app_setting_get --key=http_file_share_expires_after)

    ynh_app_setting_set_default --key=rooms_persistent --value="true"
    rooms_persistent=$(ynh_app_setting_get --key=rooms_persistent)

    ynh_print_info "Adding Prosody configuration files..."

    # Add 00.cfg.lua, needed to customize some settings acrros all prosody vhosts
    ynh_config_add --template="00.cfg.lua" --destination="/etc/prosody/conf.avail/00.cfg.lua"
    ln -srf /etc/prosody/conf.avail/00.cfg.lua /etc/prosody/conf.d/

    # SASL2 stack (XEP-0388 SASL2, XEP-0386 Bind2, XEP-0484 FAST + inline stream
    # management/resumption). These modules ship with Prosody 13; they do not
    # exist on the Prosody 0.12 that Debian Bookworm provides, so only enable
    # them on newer Debian (Trixie and later).
    if grep -q "^VERSION_CODENAME=bookworm" /etc/os-release ; then
        sasl2_modules=""
    else
        sasl2_modules='"sasl2"; "sasl2_bind2"; "sasl2_sm"; "sasl2_fast";'
    fi

    # Add domain configuration
    ynh_config_add --template="domain.tpl.cfg.lua" --destination="/etc/prosody/conf.avail/${domain}.cfg.lua"
    ln -srf /etc/prosody/conf.avail/${domain}.cfg.lua /etc/prosody/conf.d/

    # Add content for /.well-known/host-meta (XEP-0156: Discovering Alternative XMPP Connection Methods)
    ynh_print_info "Creating content for \"/.well-known/host-meta\""
    ynh_config_add --template="nginx_well-known_host-meta.xml" --destination="/var/www/.well-known/${domain}/host-meta"
    chmod 644 /var/www/.well-known/${domain}/host-meta

    # Add nginx config for xmpp subdomains
    ynh_print_info "Configuring NGINX for extra domains (muc, pubsub, xmpp-upload...) and extra URLs (bosh, websocket)..."
    ynh_config_add --template="nginx_prosody.conf" --destination="/etc/nginx/conf.d/${domain}.d/prosody.conf"

    cp -R "../conf/hook_conf_regen" "/usr/share/yunohost/hooks/conf_regen/98-nginx_$app"
    YNH_HELPERS_VERSION=1 yunohost tools regen-conf nginx
}

_setup_initial_app_permissions() {
    # Before fixing issue #55 (https://github.com/YunoHost-Apps/prosody_ynh/issues/55) all
    # yunohost users were allowed to use prosody, regardless of actual yunohost permissions.
    # This workaround ensures that the permission mechanism is now really in use, even when
    # upgrading from an older version of the app.

    local verbosity=${1:-verbose}

    if [ "$(ynh_app_setting_get --app=prosody --key=_is_workaround_for_missing_permissions_already_applied)" != "yes" ] ; then
        test "${verbosity}" != "quiet" && ynh_print_warn "Applying workaround for missing yunohost permissions..."

        yunohost user permission add prosody all_users

        test "${verbosity}" != "quiet" && ynh_print_warn "From now on, only yunohost users with 'prosody' permission can use this service."
        test "${verbosity}" != "quiet" && ynh_print_warn "Right now, this includes **all** valid yunohost users. You may customize this if you want."

        # Prevent applying this workaround again in the future
        ynh_app_setting_set --app=prosody --key=_is_workaround_for_missing_permissions_already_applied --value=yes
    fi
}

_ensure_extra_modules_are_installed() {
    # Some useful prosody modules may not be available in Debian repositories yet.
    # When this is the case, we install them "manually". And when these modules are
    # finally included in Debian, we remove the "manually" installed ones.
    if grep -q "^VERSION_CODENAME=bookworm" /etc/os-release ; then
        if ! prosodyctl list | grep -q ^mod_cloud_notify_extensions ; then
            ynh_print_info "Installing mod_cloud_notify_extensions \"manually\" because it is not available in Debian Bookworm."
            prosodyctl install --server=https://modules.prosody.im/rocks/ mod_cloud_notify_extensions
            ynh_systemctl --service=$app --action="restart"
        fi
    else
        if prosodyctl list | grep -q ^mod_cloud_notify_ ; then
            ynh_print_info "Uninstalling mod_cloud_notify_extensions that was previously installed \"manually\". It is now included in Debian."
            # First uninstall mod_cloud_notify_extensions, and then its dependencies
            prosodyctl remove mod_cloud_notify_extensions
            for mod in $(prosodyctl list | grep ^mod_cloud_notify_); do prosodyctl remove ${mod} ; done
            ynh_systemctl --service=$app --action="restart"
        fi
    fi
}
