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
mv /home/todo/user/systemd.service /etc/systemd/system/user.service

Head "Restart the services"
systemctl daemon-reload && systemctl restart users && systemctl status users
