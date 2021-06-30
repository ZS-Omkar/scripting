#!/bin/bash

source components/common.sh

OS_PREREQ

Head "Installing Nginx"
apt install nginx -y &>>$LOG
Stat $?

Head "Installing nodejs and npm"
apt install nodejs -y &>>$LOG
apt install npm -y &>>$LOG
Stat $?

Head "Removing the default file in sites-available and sites-enabled"
cd /etc/nginx/sites-available && rm -rf default
cd /etc/nginx/sites-enabled && rm -rf default

Head "changing the directory and creating a new directory"
cd /var/www/html && mkdir vue

cd vue

Head "cloning the repo"
git clone https://github.com/ZS-Omkar/frontend.git

cd frontend

Head "Installing the dependencies and run npm"
npm install &>>$LOG
npm run build &>>LOG

Head "moving the config file to nginx path"
mv /var/www/html/vue/frontend/default.config /etc/nginx/sites-enabled

Head "Restarting nginx services"
systemctl daemon-reload
systemctl enable nginx
systemctl restart nginx


