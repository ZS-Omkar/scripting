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

Head " Build the Source-code"
export GOPATH=~/go &>>$LOG
depmod && apt install go-dep &>>$LOG
cd login
dep ensure && go get &>>$LOG && go build &>>$LOG
Stat $?

Head "Now move the user services"
mv /root/go/src/login/login.service /etc/systemd/system/login.service

Head "Restart the services"
systemctl daemon-reload
systemctl start login
systemctl status login
