#!/bin/bash

function usage {
  echo "Usage: $(basename $0) -i [image]" 2>&1
  echo "Example: kill-docker-images.sh -i image"
  echo '  -i    the image name to be killed'
  exit 1
}

options=":i:"

while getopts ${options} arg; do
  case "${arg}" in
    i)
       image="${OPTARG}"
       ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      echo
      usage
      ;;
  esac
done

if [[ $image ]]; then
  echo "Killing all images with name:" $image
  docker ps | grep $image | awk '{ print $1;}' | xargs docker kill
fi
