#!/bin/bash

source components/common.sh

OS_PREREQ

Head "Install java-openjdk"
apt-get install openjdk-8-jdk-headless -y &>>$LOG
Stat $?

Head "Installing Maven"
apt install maven -y &>>$LOG
Stat $?

Head "Cloning the repo"
git clone https://github.com/ZS-Omkar/users.git

cd users

Head "cleaning the maven package"
mvn clean package &>>$LOG

Head "Now move the user services"
mv /etc/systemd/system/multi-user.target /scripting/Todo/users/users.service

Head "Restart the services"
systemctl daemon-reload && systemctl start users && systemctl enable users && systemctl status users
