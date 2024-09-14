#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

#FIXME: does not work as manifest.toml lua5.4 dependencies have to be updated accordingly
#if [[ $(lsb_release --codename --short) == "bookworm" ]]; then
#	luaversion="5.4"
#else
	luaversion="5.2"
#fi
