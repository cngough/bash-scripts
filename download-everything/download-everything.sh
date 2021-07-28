#!/bin/bash
#title           :download-everything.sh
#description     :Given a URL it will download absolutely everything and put it in nice nested directories
#author          :github.com/cngough
#date            :20181015
#version         :0.1
#==============================================================================

# Basic sanitisation - null $1
if [ -z "$1" ] ; then 
	echo "Usage is download-everything.sh [url-of-resources]"
	exit 1
fi

# Again we're doing this insecurely (--no-check-certificate) for now
wget --no-check-certificate --mirror -p --convert-links -P ./ $1
