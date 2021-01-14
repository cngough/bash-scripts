#!/bin/bash

function usage {
  echo "Usage: $(basename $0) -e [old email;new email] -n [old name;new name] -f" 2>&1
  echo "Example: update-git-author.sh -e \"john@foo.com;john@bar.com\" -n \"jsmith;John Smith\""
  echo '  -e    replaces an old author email address with the provided one'
  echo '  -n    replaces an old author name with the provided one'
  echo '  -f    forces Git to force filter-branch'
  exit 1
}

if [[ ${#} -eq 0 ]]; then
   usage
fi

options=":enf"

while getopts ${options} arg; do
  case "${arg}" in
    e)
       echo "argument -e called with parameter $OPTARG" >&2;;
    n) 
      echo "N VALUE: ${OPTARG}";;
    ?)
      echo "Invalid option: -${OPTARG}."
      echo
      usage
      ;;
  esac
done

# echo "Replacing commits by '$1' with '$2', '$3'"
# echo "Continue? [y/n]"
# read CONFIRM

# if [[ ! $CONFIRM =~ ^[Yy]$ ]]
#   then
#     exit 1
# fi

# git filter-branch --commit-filter '
#         if [ "$GIT_AUTHOR_EMAIL" = "$1" ];
#         then
#                 GIT_AUTHOR_NAME="$2";
#                 GIT_AUTHOR_EMAIL="$3";
#                 git commit-tree "$@";
#         else
#                 git commit-tree "$@";
#         fi' HEAD
