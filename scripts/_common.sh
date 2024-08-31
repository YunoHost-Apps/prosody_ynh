#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

if [[ $(lsb_release --codename --short) == "bookworm" ]]; then
	luaversion="5.4"
else
	luaversion="5.2"
fi
