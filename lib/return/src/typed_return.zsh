#
# Initialize base storage
#
function @setup_storage()
{
  typeset -x pass_arg_result
  typeset -x pass_arg_type_info
  typeset -x pass_arg_type_info_description
}

#
# Store the given value in type
#
# @param target_type {string, integer, double, array, association}
# @param result Result value to be stored. Must be `eval`-able form.
#
function @store()
{
  local -A type_translation=(
    string      ''
    integer     '-i'
    double      '-F'
    array       '-a'
    association '-A'
  )

  # Validates given target type is valid
  local target_type=${1}

  if [[ ${type_translation[(I)${target_type}]} != ${target_type} ]]
  then
    echo 'Error: Invalid type parameter was given' 1>&2
    return 1
  fi

  # Ignore first type parameter
  shift

  # Store to shared store
  pass_arg_type_info=${type_translation[${target_type}]}
  pass_arg_type_info_description=${target_type}
  pass_arg_result=$*
}

#
# Load value into specified variable
# Note that the variable will be generated in export-scope.
#
# @param variable_name
#
function @load()
{
  local variable_name=$1

  # Validate given variable name
  if ! [[ ${variable_name} =~ ^[a-zA-Z0-9_@]+$ ]] || [[ ${variable_name} == 'pass_arg_result' || ${variable_name} == 'pass_arg_type_info' ]]
  then
    echo 'Error: Variable name must belong to [a-zA-Z0-9_@]+, and not equal to "pass_arg_result" or "pass_arg_type_info"' 1>&2
    return 1
  fi

  # Prepare container of result (for eval)
  local -A result_container_symbol=(
    string_left       "'"
    string_right      "'"
    integer_left      ''
    integer_right     ''
    double_left       ''
    double_right      ''
    array_left        '('
    array_right       ')'
    association_left  '('
    association_right ')'
  )

  local -A symbol=(
    left  ${result_container_symbol[${pass_arg_type_info_description}_left]}
    right ${result_container_symbol[${pass_arg_type_info_description}_right]}
  )

  # Generate variable
  eval "typeset -x ${pass_arg_type_info} ${variable_name}=${symbol[left]}${pass_arg_result}${symbol[right]}"
}
