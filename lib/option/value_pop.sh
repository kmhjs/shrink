#
# Pop value for specified option
#
# Search target option from head, set result value correspond to given option, and remove from args
# Note that this function will change external variables named as `input_variable_name` and `output_variable_name`
#
# @param input_variable_name Input variable name (will be modified in this method)
# @param output_variable_name Output variable name (Value will be stored to this)
# @param option_key Target option name
#
function @option::value_pop()
{
  local input_variable_name=$1
  local output_variable_name=$2
  local option_key=$3

  if [[ -z ${input_variable_name} || -z ${output_variable_name} || -z ${option_key} ]]
  then
    echo 'Error: Invalid arguments' 1>&2
    return 1
  fi

  local -a values=(${(P)input_variable_name})
  local -i option_key_idx=${values[(i)${option_key}]}

  local value=${values[$((${option_key_idx} + 1))]}
  if [[ -z ${value} ]]
  then
    return 1
  fi

  values[${option_key_idx},$((${option_key_idx} + 1))]=()
  eval "${input_variable_name}=(${values})"
  eval "${output_variable_name}=${value}"

  return 0
}
