#
# Load source tool
#
source "$(dirname $0)/../../../src/source_relative.zsh" $0 -w

#
# Source libraries
#
@source_relative 'lib/format_info.sh'
@source_relative 'lib/zcl/zcl'
@source_relative 'lib/color_echo/color_echo.zsh'

#
# Disable @source_relative in caller scope
#
unfunction @source_relative
