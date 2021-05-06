#!/bin/bash

source components/common.sh

OS_PREREQ

HEAD "Installing Nginx"
apt install nginx

HEAD "Installing nodejs and npm"
apt install nodejs
apt install npm

HEAD "changing the directory and creating a new directory"
cd /var/www/html && mkdir vue

cd... vue

HEAD "cloning the repo"
git clone  https://github.com/zelar-soft-todoapp/frontend.git

cd... frontend

HEAD "Installing the dependencies and run npm"
npm install
npm run build

HEAD "Change the path of Nginx"
sed -i -e 's+root /var/www/html+root /var/www/html/vue/frontend/dist+g' /etc/nginx/sites-available/default

HEAD "Restarting nginx services"
systemctl restart nginx
systemctl enable nginx




