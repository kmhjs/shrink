#
# Load source tool
#
source "$(dirname $0)/../../../src/source_relative.zsh" $0 -w

#
# Source libraries
#
@source::relative 'lib/format_info.sh'
@source::relative 'lib/zcl/zcl'
@source::relative 'lib/color_echo/color_echo.zsh'

#
# Disable @source_relative in caller scope
#
unfunction @source::relative
