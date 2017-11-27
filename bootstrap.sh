#!/bin/sh

# Usage: in_list <string> <string_list>
in_list() {
  var="$1"
  for item in "${@:2}"
  do
    echo "$item"
    if [[ "$item" == "$1" ]]; then
      return 0
    fi
  done
  return 1
}

main() {
  in_list "all" "$@" && echo 'in list' || echo 'not in list'
}

main $@

