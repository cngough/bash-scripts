#!/bin/bash

function usage {
  echo "Usage: $(basename $0) -b [optional branch]" 2>&1
  echo "Example: pull-all-projects.sh -b develop"
  echo '  -b    only updates branches that match the name'
  exit 1
}

options=":b:"

while getopts ${options} arg; do
  case "${arg}" in
    b)
       branch="${OPTARG}"
       ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      echo
      usage
      ;;
  esac
done

if [[ $branch ]]; then
  echo "Pulling all branches that are currently on" $branch
  all_branches=(`find . -name ".git" -type d | sed 's/\/.git//'`)
  parsed_branches=()
  for val in ${all_branches[@]}; do
    if [ `git -C $val branch --show-current` == $branch ]; then 
      parsed_branches+=($val)
    fi
  done
  printf '%s\n' "${parsed_branches[@]}" | xargs -P10 -I% git -C % pull
else
  echo "Pulling all branches in subdirectories"
  find . -name ".git" -type d | sed 's/\/.git//' | xargs -P10 -I% git -C % pull
fi