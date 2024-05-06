#!/bin/bash

source ./common.sh

check_root

echo "Please enter DB passsword : "
read -s mysql_root_password

dnf install mysqld &>>$LOGFILE

systemctl enable mysqld &>>$LOGFILE
systemctl start mysqld &>>$LOGFILE

#below code will be usefull for idempotent nature

mysql -h 172.31.24.133 -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then 
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
else
    echo -e "Mysql root password is already setup...$Y Skipping $N"
fi

