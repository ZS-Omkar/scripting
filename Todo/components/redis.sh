#!/bin/bash

source components/common.sh

OS_PREREQ

Head "Install redis-server"
apt install redis-server -y
Stat $?

Head "Changing the IP address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
Stat $?

Head "Restart the services"
systemctl start redis
Stat $?