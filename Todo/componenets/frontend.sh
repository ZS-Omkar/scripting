#!/bin/bash

source common.sh

OS_PREREQ

HEADING "Installing Nginx"
apt install nginx -y &>>"$LOG"
Stat $?

HEADING "Installing nodejs and npm"
apt install nodejs -y &>>"$LOG"
Stat $?

apt install npm -y &>>"$LOG"
Stat $?

HEADING "changing the directory and creating a new directory"
cd /var/www/html && mkdir vue

cd vue || exit

HEADING "cloning the repo"
git clone  https://github.com/zelar-soft-todoapp/frontend.git

cd frontend || exit

HEADING "Installing the dependencies and run npm"
npm install
npm run build
Stat $?

HEADING "Change the path of Nginx"
sed -i -e 's+/var/www/html+/var/www/html/vue/frontend/dist+g' /etc/nginx/sites-available/default

HEADING "Restarting nginx services"
systemclt restart nginx
systemctl enable nginx




