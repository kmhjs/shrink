#
# Verifies given index is valid for array
#
# @param index
# @param args Target array
#
function @array::is_valid_index()
{
 local -i index=$1
 shift

 (( ${index} < $(($# + 1)) ))
}

#
# Returns first index of given value
#
# This method behaves almost same to (i) expansion,
# returns the status code is the difference.
#
# Example:
#  $0 target a b c d target
#  => Outputs 5 (index value of first 'target')
#
# @param element Search target element
# @param array Search target array
# @return index value
#
function @array::first_index()
{
  local element=$1
  shift

  local -i idx=${*[(i)${element}]}
  echo ${idx}

  [[ ${idx} == $(($# + 1)) ]]
}
