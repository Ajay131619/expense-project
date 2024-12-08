#!/bin/bash

# Author: Ajay

#date : Sun, Dec  8, 2024  4:51:00 PM

#script name:mysql.sh

#description :: In this script , I am going to install the mysql tool ,setup the password and the username for the sql server, and I will also start and enable the mysql service and we will also check the service and the server is working or not 

# here goes the script

folder="/var/log/EX-P_logs"
timestamp=$(date)
scriptname=$(echo $0 | awk -F "." {'print $1F'})
logfile="$folder/$scriptname-$timestamp.log"

r="\e[33m" #red colour code
g="\e[32m" #green colour code
y="\e[31m" #yellow colour code
n="\e[0m"  #no colour code

#these colours are used for better user experience 


userid=$(id -u)

check(){

    if [ $userid -eq 0 ]
    then
        echo -e " the execution of the script is $g started $n"
        mkdir -p $folder
        echo -e " check the logs in this folder ->> $y "/var/log/EX-P_logs" $n "
    else
        echo -e " please run this script only using $y sudo access $n "
        echo -e " the execution of the script is $r failed $n"
        exit 1
    fi

}

valid(){
if [ $? -eq 0 ]
then
    echo -e " mysql server $1 is $g success $n "
else
    echo -e " mysql server $1 is $r failed $n "
    exit 1
fi
}

installation(){

    if [ $? -eq 0 ]
    then
        echo "checking mysql is installed or not??"
        dnf list installed mysql
        if [ $? -eq 0 ]
        then 
            echo -e " mysql is $g already installed ! $n "
            echo " nothing to do!!"
            exit 1
        else
            echo -e " mysql is $r not installed in your system ! $n "
            echo -e " $y going to install mysql in your system ! $n "
            dnf install mysql-server -y        
            valid installation
        fi

    fi
}

starting_enabling(){

if [ $? -eq 0 ]
then
    echo -e " $y going to start the mysql service!! $n "
    systemctl start mysqld
    if [ $? -eq 0 ]
    then
        echo -e " mysql server is $g started $n "
        echo -e " going to $y enable $n the mysql "
        systemctl enable mysqld
        if [ $? -eq 0 ]
        then
            echo -e " mysql server is $g enabled successfully $n "
        else
            echo -e " mysql server is $r failed to enable $n "
        fi

else
    echo -e " mysql server is $r failed to start $n"
fi

}

#calling the functions 

check

installation

starting_enabling