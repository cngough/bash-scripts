#!/bin/bash

function usage {
  echo "Usage: $(basename $0) -c [container]" 2>&1
  echo "Example: kill-docker-containers.sh -c container"
  echo '  -c    the container name to be killed'
  exit 1
}

options=":c:"

while getopts ${options} arg; do
  case "${arg}" in
    c)
       container="${OPTARG}"
       ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      echo
      usage
      ;;
  esac
done

if [[ $container ]]; then
  echo "Killing all containers with name:" $container
  docker ps | grep $container | awk '{ print $1;}' | xargs docker kill
fi
