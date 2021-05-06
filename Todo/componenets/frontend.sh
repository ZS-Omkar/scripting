#!/bin/bash

source common.sh

OS_PREREQ

HEAD "Installing Nginx"
apt install nginx -y &>>"$LOG"
Stat $?

HEAD "Starting and enabling nginx"
systemctl start nginx && systemctl enable nginx

HEAD "Installing nodejs and npm"
apt install nodejs -y &>>"$LOG"
Stat $?

apt install npm -y &>>"$LOG"
Stat $?

HEAD "changing the directory and creating a new directory"
cd /var/www/html && mkdir vue

cd vue || exit

HEAD "cloning the repo"
git clone  https://github.com/zelar-soft-todoapp/frontend.git

cd frontend || exit

HEAD "Installing the dependencies and run npm"
npm install
npm run build
Stat $?

HEAD "Change the path of Nginx"
sed -i -e 's+/var/www/html+/var/www/html/vue/frontend/dist+g' /etc/nginx/sites-available/default

HEAD "Restarting nginx services"
systemctl restart nginx
systemctl enable nginx




