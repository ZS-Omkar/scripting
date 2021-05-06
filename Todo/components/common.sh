#!/bin/bash

OS_PREREQ(){
  LOG=/tmp/${COMPONENT}.log
  rm -f $LOG
  set-hostname "${COMPONENT}"
  apt update &>$LOG
}
