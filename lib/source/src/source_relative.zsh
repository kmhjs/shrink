#
# source_relative
#
# Usage: source 'source_relative.zsh' $0
# Note: $0 in example usage is script path of caller
#
#
# --- Example usage ---
#
# # Load source tool
# #
# source "$(dirname $0)/util/source_relative.zsh" $0 -w
#
# #
# # Source libraries
# #
# @source::relative 'lib/lib1.sh'
# @source::relative 'lib/lib2.sh'
#
# #
# # Disable @source_relative in caller scope
# #
# unfunction @source::relative
#
# -- end ---
#

#
# Configure internal states
#

# Parse base path
typeset script_base_path=$(dirname $1)

# Parse warning option
[[ ${*[(I)-w]} != 0 ]]
typeset -i enable_warning=$?

#
# Source alias task
# Usage: @source_relative [-q] source_target_path (from parent script)
#
function @source::relative()
{
  # Parse quiet option
  local -i enable_quiet=1
  if [[ $1 == '-q' ]]
  then
    enable_quiet=0
    shift
  fi

  # Parse and validate target script path
  local target_path=$1
  local expected_path="${script_base_path}/${target_path}"

  if [[ ! -f ${expected_path} ]] && (( ${enable_warning} == 0 ))
  then
    echo "warning: File not found in expected path : ${expected_path}" 1>&2
    return 1
  fi

  # Source
  if (( ${enable_quiet} == 0 ))
  then
    source "${script_base_path}/${target_path}" 1>/dev/null 2>/dev/null
  else
    source "${script_base_path}/${target_path}"
  fi
}
