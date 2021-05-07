#!/bin/bash

source components/common.sh

OS_PREREQ

Head "Installing go from the below link and export the path"
wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
export PATH=$PATH:/usr/local/go/bin
source ~/.profile

Head "create a directory and cd into the directory and create one more directory"
mkdir /go
cd /go
mkdir src
cd src

Head "Clone the repo"
git clone https://github.com/ZS-Omkar/login.git

Head "Now cd into login, export go path and build go"
cd login
export GOPATH=/go
go build

./login
