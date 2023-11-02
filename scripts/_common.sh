#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

if [[ $(lsb_release --codename --short) == "bookworm" ]]; then
	luaversion="5.4"
else
	luaversion="5.2"
fi

# dependencies used by the app
#REMOVEME? pkg_dependencies="libicu-dev libidn11-dev|libidn-dev liblua${luaversion}-dev libssl-dev lua-busted lua${luaversion} lua${luaversion}-expat lua${luaversion}-socket openssl txt2man lua${luaversion}-sec lua${luaversion}-unbound"

#=================================================
# PERSONAL HELPERS
#=================================================

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
