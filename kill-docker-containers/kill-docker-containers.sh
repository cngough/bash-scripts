#!/bin/bash
#title           :kill-all-docker-containers.sh
#description     :Kills running Docker containers with a given name
#author			     :github.com/cngough
#date            :20210720
#version         :0.1
#==============================================================================

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
