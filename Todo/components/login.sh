#!/bin/bash

source components/common.sh

OS_PREREQ

Head "Installing go from the below link and export the path"
wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
export PATH=$PATH:/usr/local/go/bin
source ~/.profile
go version

Head "create a directory and cd into the directory and create one more directory"
mkdir ~/go && cd ~/go && mkdir src && cd src

Head "Clone the repo"
git clone https://github.com/ZS-Omkar/login.git

cd login

Head " Build the Source-code"
export GOPATH=~/go &>>$LOG
go get &>>$LOG && go build &>>$LOG
Stat $?

Head "Now move the services"
mv /root/go/src/login/login.service /etc/systemd/system/login.service

Head "updating DNS"
sed -i -e "s/172.31.1.135/users.bethas.online/" /etc/systemd/system/login.service

Head "Restart the service"
systemctl daemon-reload
systemctl enable login
systemctl start login
