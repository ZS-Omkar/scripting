#!/bin/bash

source components/common.sh

OS_PREREQ

Head "Installing Nginx"
apt install nginx -y &>>"$LOG"
Stat $?

Head "Starting and enabling nginx"
systemctl start nginx && systemctl enable nginx

Head "Installing nodejs and npm"
apt install nodejs -y &>>"$LOG"
Stat $?

apt install npm -y &>>"$LOG"
Stat $?

Head "changing the directory and creating a new directory"
cd /var/www/html && mkdir vue

cd vue || exit

Head "cloning the repo"
git clone  https://github.com/zelar-soft-todoapp/frontend.git

cd frontend || exit

Head "Installing the dependencies and run npm"
npm install
npm run build
Stat $?

Head "Change the path of Nginx"
sed -i -e 's+/var/www/html+/var/www/html/vue/frontend/dist+g' /etc/nginx/sites-available/default

Head "Restarting nginx services"
systemctl restart nginx
systemctl enable nginx




