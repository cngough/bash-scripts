#!/bin/bash

# -I{} execThis.sh {} replaces {} with the full string 
# git -C does the same as git --git-dir (uses an OS-level directory chdir operation), with the distinction that $GIT_DIR is set to a relative path. This changes the way sub-commands locate the repository

# Task - do a check to see if we're on develop
find . -name ".git" -type d | sed 's/\/.git//' | xargs -P10 -I{} git -C {} pull
