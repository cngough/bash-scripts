#!/bin/bash

if [ $# -lt 3 ]
  then
    echo "No arguments supplied. Usage is git-fix.sh <OLD_AUTHOR_EMAIL> <NEW_AUTHOR_EMAIL> <NEW AUTHOR_EMAIL>"
    exit 1
fi

echo "Replacing commits by '$1' with '$2', '$3'"
echo "Continue? [y/n]"
read CONFIRM

if [[ ! $CONFIRM =~ ^[Yy]$ ]]
  then
    echo "Exiting without modification"
    exit 1
fi

git filter-branch --commit-filter '
        if [ "$GIT_AUTHOR_EMAIL" = "$1" ];
        then
                GIT_AUTHOR_NAME="$2";
                GIT_AUTHOR_EMAIL="$3";
                git commit-tree "$@";
        else
                git commit-tree "$@";
        fi' HEAD
