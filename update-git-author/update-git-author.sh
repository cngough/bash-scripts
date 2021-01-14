#!/bin/bash

function usage {
  echo "Usage: $(basename $0) -e [old email;new email] -n [old name;new name] -f" 2>&1
  echo "Example: update-git-author.sh -e \"john@foo.com;john@bar.com\" -n \"jsmith;John Smith\""
  echo '  -e    replaces an old author email address with the provided one'
  echo '  -n    replaces an old author name with the provided one'
  exit 1
}

if [[ ${#} -eq 0 ]]; then
   usage
fi

options=":e:n:"

while getopts ${options} arg; do
  case "${arg}" in
    e)
       IFS=";" read -r -a email <<< "${OPTARG}"
       if [[ ${#email[@]} != 2 ]]; then 
         echo "Malformed or unexpected input, ensure only one ';' is present per argument"
         exit 1
       fi
       ;;
    n) 
       IFS=";" read -r -a name <<< "${OPTARG}"
       if [[ ${#name[@]} != 2 ]]; then 
         echo "Malformed or unexpected input, ensure only one ';' is present per argument"
         exit 1
       fi
       ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      echo
      usage
      ;;
  esac
done

echo "All historic commits will be replaced that contain:" 
  if [[ $email ]]; then 
    echo "  GIT_AUTHOR_EMAIL: \"${email[0]}\" with \"${email[1]}\"" 
  fi
  if [[ $name ]]; then 
    echo "  GIT_AUTHOR_NAME: \"${name[0]}\" with \"${name[1]}\"" 
  fi

echo "Continue? [y/n]"
read CONFIRM

if [[ ! $CONFIRM =~ ^[Yy]$ ]]
   then exit 1
fi

if [[ $email && $name ]]; then 
  git filter-branch -f --commit-filter '
        if [ "$GIT_AUTHOR_NAME" = "'"${name[0]}"'" ] && [ "$GIT_AUTHOR_EMAIL" = "'"${email[0]}"'" ];
        then
                GIT_AUTHOR_EMAIL="'"${email[1]}"'";
                GIT_AUTHOR_NAME="'"${name[1]}"'";
                git commit-tree "$@";
        else
                git commit-tree "$@";
        fi' HEAD
elif [[ $email ]]; then
  git filter-branch -f --commit-filter '
        if [ "$GIT_AUTHOR_EMAIL" = "'"${email[0]}"'" ];
        then
                GIT_AUTHOR_EMAIL="'"${email[1]}"'";
                git commit-tree "$@";
        else
                git commit-tree "$@";
        fi' HEAD
else
echo "if [ \"$GIT_AUTHOR_NAME\" = \"${name[0]}\" ];"
git filter-branch -f --commit-filter '
        if [ "$GIT_AUTHOR_NAME" = "'"${name[0]}"'" ];
        then
                GIT_AUTHOR_NAME="'"${name[1]}"'";
                git commit-tree "$@";
        else
                git commit-tree "$@";
        fi' HEAD
fi

#PREVIOUS WORKING VERSION
# We're in soft quotes here so probably have to escape strings AND dollar sign
# git filter-branch -f --commit-filter '
#         if [ "$GIT_AUTHOR_NAME" = "chairs" ];
#         then
#                 GIT_AUTHOR_NAME="Chris Gough";
#                 git commit-tree "$@";
#         else
#                 git commit-tree "$@";
#         fi' HEAD

