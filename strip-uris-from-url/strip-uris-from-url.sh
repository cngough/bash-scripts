#!/bin/bash
#title           :strip-uris-from-url.sh
#description     :Given a URL and a regex it will strip all of the matching extensions from the page 
#author			 :chris@chris-gough.com
#date            :20181015
#version         :0.1
#==============================================================================

# Basic sanitisation - null $1 or $2
if [ -z "$1" ] || [ -z "$2" ] ; then 
	echo "Usage is strip-uris-from-url.sh [url-of-resources] [extensions-to-match (in quotes, separated by |)"
	exit 1
fi

# Note that when --output-document is specified, --convert-links is ignored. Bummer
# Retrieve the entire page, and retrieve the full URIs (-k) again we're doing this insecurely (--no-check-certificate) for now
wget -k --no-check-certificate $1

# We will need to change index.html to whatever the output from wget is 
cat index.html | grep -Po '(?<=href=")[^"]*' | grep -E '^.*\.('$2')$' > stripped-uris-output-`date +%s%N` && rm index.html
