#! /usr/bin/env zsh

source './typed_return.zsh'

function example_string()
{
  local string_variable='this is string'
  @return::typed::store string ${string_variable}
}

function example_array()
{
  local -a array_variable=(1 2 3)
  @return::typed::store array ${array_variable}
}

function example_associated_array()
{
  local -a association_variable=(key_1 1 key_2 2)
  @return::typed::store association ${(kv)association_variable}
}

function ::equals()
{
  if [[ "${1}" != "${2}" ]]
  then
    echo "Fail: '${1}' != '${2}'" 1>&2
    return 1
  fi
}

# Prepare
@return::typed::setup_storage

# Test string pattern
example_string
@return::typed::load string

::equals "${string}" 'this is string'
::equals ${(t)string} 'scalar-export'

# Test array pattern
example_array
@return::typed::load array

::equals "${array}" '1 2 3'
::equals ${#array} 3
::equals ${(t)array} 'array-export'

# Test associated array pattern
example_associated_array
@return::typed::load associated_array

::equals "${(k)associated_array}" 'key_1 key_2'
::equals "${(v)associated_array}" '1 2'
::equals "${(kv)associated_array}" 'key_1 1 key_2 2'
::equals ${#associated_array} 2
::equals ${(t)associated_array} 'association-export'
