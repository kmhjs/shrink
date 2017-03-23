#! /usr/bin/env zsh

source './src/dependencies.sh'

color_echo -c green_bold "$(zcl ./conf/user.conf format_info :name :id)"
