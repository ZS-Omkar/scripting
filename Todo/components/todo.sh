#!/bin/bash

source components/common.sh

OS_PREREQ

Head "Installing nodejs and npm"
apt install nodejs -y &>>$LOG
apt install npm -y &>>$LOG
Stat $?

Head "cloning the repo"
git clone https://github.com/ZS-Omkar/todo.git

Head "changing the directory and installing npm"
cd todo
npm install &>>$LOG

Head "Changing the path"
mv /root/scripting/Todo/todo/todo.service /etc/systemd/system/todo.service

Head "updating DNS name"
sed -i -e "s/172.31.0.187/redis.bethas.online/" /etc/systemd/system/todo.service

Head "Restart the todo service"
systemctl daemon-reload
systemctl enable todo
systemctl start todo
