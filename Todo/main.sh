#!/bin/bash

COMPONENT=$1

source components.common.sh

if [ ! -f components/"${COMPONENT}".sh ]; then
  echo "Invalid Component Name is Provided"
  exit 1
fi

USER_NAME=$(whoami)

if [ "${USER_NAME}" != "root" ]; then
  echo "You Should be a root user to perform this script, Try with sudo"
  eixt 1
fi

export COMPONENT
bash components/"${COMPONENT}".sh