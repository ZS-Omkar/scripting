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

Head "Removing html file"
cd /var/www/html && rm -rf index.nginx-debian.html && mkdir vue
Stat $?

ls

Head "changing the path of directory"
cd vue

Head "cloning the repo"
git clone https://github.com/ZS-Omkar/frontend.git

cd frontend

Head "moving the config file to nginx path"
mv /var/www/html/vue/frontend/default.config /etc/nginx/sites-enabled

Head "Installing the dependencies and run npm"
npm install &>>$LOG
npm run build &>>LOG

Head "exporting the variables of login and todo"

export AUTH_API_ADDRESS=http://bethas.online:8080
export TODOS_API_ADDRESS=http://bethas.online:8080


Head "Restarting nginx services"
systemctl daemon-reload
systemctl enable nginx
systemctl restart nginx


