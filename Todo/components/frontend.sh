#!/bin/bash

source components/common.sh

OS_PREREQ

HEAD "Installing Nginx"
apt install nginx &>$LOG

HEAD "Installing nodejs and npm"
apt install nodejs &>$LOG
apt install npm &>$LOG

HEAD "changing the directory and creating a new directory"
cd /var/www/html && mkdir vue

cd vue || exit

HEAD "cloning the repo"
git clone https://github.com/zelar-soft-todoapp/frontend.git

cd frontend ||  exit

HEAD "Installing the dependencies and run npm"
npm install &>$LOG
npm run build

HEAD "Change the path of Nginx"
sed -i -e 's+root /var/www/html+root /var/www/html/vue/frontend/dist+g' /etc/nginx/sites-available/default

HEAD "Restarting nginx services"
systemctl restart nginx
systemctl enable nginx




