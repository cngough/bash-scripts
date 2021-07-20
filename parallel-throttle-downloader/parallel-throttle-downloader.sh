#!/bin/bash
#title           :parallel-throttle-downloader.sh
#description     :Downloads from a list of URLs with a configurable amount of concurrent downloads
#author			 :chris@chris-gough.com
#date            :20181005
#version         :0.1
#==============================================================================

# Basic sanitisation - null $1 or $2, invalid positive integer or file doesn't exist 
if [ -z "$1" ] || [[ ! "$1" =~ ^[1-9]+[0-9]*$ ]] || [ -z "$2" ] || [ ! -f "$2" ] ; then 
	echo "Usage is parallel-throttle-downloader.sh [^[1-9]+[0-9]*$] [file of URIs]"
	exit 1
fi
	
# Currently we're doing this insecurely (curl -k)
cat $2 | xargs -n1 -P$1 -I % curl -k % -O
