#!/bin/sh

#TODO: make all the backup shit configurable
#Just make the logic better, such as make the options definable in one place
#only

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd )"

bootstrap_options=("vim" "bash" "i3" "x" "termite" "wallpapers")
special_options=("all" "options")
options=("${special_options[@]}" "${bootstrap_options[@]}")
initial_params="$@"

# Usage: in_list <string> <strings>
in_list() {
  for item in "${@:2}"
  do
    if [[ "$item" == "$1" ]]; then
      return 0
    fi
  done
  return 1
}

bootstrap_vim() {
  echo "source $SCRIPTPATH/vim/main.vim" > vim/.vimrc
  cp -b vim/.vimrc ~
  echo "done bootstraping vim"
}

bootstrap_bash() {
  cp -b $SCRIPTPATH/bash/.bash* ~
  echo "done bootstraping bash"
}

bootstrap_i3() {
  cp -b $SCRIPTPATH/i3/* ~/.config/i3/
  echo "done bootstraping i3"
}

bootstrap_x() {
  echo "done bootstraping x"
}

bootstrap_termite() {
  echo "done bootstraping termite"
}

bootstrap_wallpapers() {
  cp -b wallpapers/.fehbg ~
  echo "done bootstraping wallpaper"
}

bootstrap_by_param() {
  case "$1" in
    "vim") bootstrap_vim;;
    "bash") bootstrap_bash;;
    "i3") bootstrap_i3;;
    "x") bootstrap_x;;
    "termite") bootstrap_termite;;
    "wallpapers") bootstrap_wallpapers;;
  esac
}

bootstrap_by_params() {
  for param do
    bootstrap_by_param "$param";
  done
}

print_usage() {
  ( IFS='|'; echo "usage: ./bootstrap.sh all | ./bootstrap.sh options | ./bootstrap.sh ${bootstrap_options[*]}" )
}

exit_invalid_usage() {
  echo "invalid arguments: $initial_params"
  print_usage
  exit 1
}

validate_params() {
  for param do
    if ! in_list "$param" "${options[@]}"; then
      exit_invalid_usage
    fi;
  done
}

validate_special_params() {
  for param do
    if in_list "$param" "${special_options[@]}"; then
      found_special=true
    fi;
  done

  if [ \( "$#" -gt 1 \) -a \( "$found_special" = true \) ]; then
    exit_invalid_usage
  fi
}

handle_special_params() {
  validate_special_params "$@"

  case "$1" in
    "all")
      bootstrap_by_params "${bootstrap_options[@]}"
      exit 0;;
    "options")
      print_usage
      exit 0;;
  esac
}

main() {
  validate_params "$@"

  handle_special_params "$@"


  bootstrap_by_params "$@"
}

main $@

