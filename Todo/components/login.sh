#!/bin/bash

source components/common.sh

OS_PREREQ

Head "Installing go from the below link and export the path"
wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
export PATH=$PATH:/usr/local/go/bin
source ~/.profile
go version

Head "create a directory and cd into the directory and create one more directory"
mkdir ~/go
cd ~/go
mkdir src
cd src

Head "Clone the repo"
git clone https://github.com/ZS-Omkar/login.git

Head "Now cd into login, export go path and build go"
cd login
export GOPATH=~/go
go get
go build

Head "Now move the user services"
mv /root/scripting/Todo/login/login.service /etc/systemd/system/multi-user.target

Head "Restart login service"
systemctl daemon-reload
systemctl restart multi-user.target
systemctl enable multi-user.target

