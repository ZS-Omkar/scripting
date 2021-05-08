#!/bin/bash

source components/common.sh

OS_PREREQ

Head "Install redis-server"
apt install redis-server -y &>>$LOG
Stat $?

Head "Changing the IP address"
sed -i -e 's/100.25.141.67/0.0.0.0/' /etc/redis/redis.conf
Stat $?

Head "Restart the services"
systemctl start redis
Stat $?