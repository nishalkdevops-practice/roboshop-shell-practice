#!/bin/bash


DATE=$(date +%F)
LOGDIR=/tmp
SCRIPT_NAME=$0
LOGFILE=$LOGDIR/$0-$DATE.log



USERID=$(id -u)

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

if [ $USERID -ne 0 ]
then
    echo -e  "$R ERROR: Please run the script with the root user credentials $N"
    exit 1
fi


VALIDATE(){

if [ $1 -ne 0 ];
then
    echo -e "$2 $R ERROR $N: Installation"
    exit 1
else
    echo -e "$2 $G SUCCESSFUL $N: Installation"
fi

}


curl -sL https://rpm.nodesource.com/setup_lts.x | bash




yum install nodejs -y


useradd roboshop


mkdir /app


curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip


cd /app 


unzip /tmp/catalogue.zip


cd /app


npm install 


vim /etc/systemd/system/catalogue.service


systemctl daemon-reload


systemctl enable catalogue


systemctl start catalogue


vim /etc/yum.repos.d/mongo.repo


yum install mongodb-org-shell -y


mongo --host 172.31.63.104 </app/schema/catalogue.js