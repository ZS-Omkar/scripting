#!/bin/bash

source components/common.sh

OS_PREREQ

Head "Installing nodejs and npm"
apt install nodejs -y &>>$LOG
apt install npm -y &>>$LOG
Stat $?

Head "cloning the repo"
git clone https://github.com/ZS-Omkar/todo.git

Head "change the directory and install the npm dependencies"
cd todo

npm start &>>$LOG

Head "Changing the path"
mv /root/scripting/Todo/todo/todo.service /etc/systemd/system/todo.service

Head "Restart the todo service"
systemctl daemon-reload
systemctl start todo
systemctl status todo
