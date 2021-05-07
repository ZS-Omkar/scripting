#!/bin/bash

source components/common.sh

OS_PREREQ

Head "Installing Nginx"
apt install nginx -y &>>$LOG

Head "Installing nodejs and npm"
apt install nodejs -y &>>$LOG
apt install npm -y &>>$LOG

Head "changing the directory and creating a new directory"
cd /var/www/html && mkdir vue

cd vue

Head "cloning the repo"
git clone 'https://github.com/zelar-soft-todoapp/frontend.git'

cd frontend

Head "Installing the dependencies and run npm"
npm install &>>$LOG
npm run build &>>LOG

Head "Change the path of Nginx"
sed -i -e 's+root /var/www/html+root /var/www/html/vue/frontend/dist+g' /etc/nginx/sites-available/default

Head "Restarting nginx services"
systemctl restart nginx
systemctl enable nginx




