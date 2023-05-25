#!/bin/bash

function main {
    echo "HOSTNAME = $(hostname)"
    echo "TIMEZONE = $(cat /etc/timezone) $(date -u "+%Z") $(date "+%z")" 
    echo "USER = $(whoami)"
    echo "OS = $(cat /etc/issue | awk '{print $1,$2,$3}' | tr -s '\r\n' ' ')"
    echo "DATE = $(date "+%d %b %Y %H:%M:%S")"
    echo "UPTIME = $(uptime -p)"
    echo "UPTIME_SEC = $(cat /proc/uptime | awk '{print $1}')"
    echo "IP = $(wget -qO- eth0.me)"
    echo "MASK = $(ifconfig | grep -m1 netmask | awk '{print $4}')"
    echo "GATEWAY = $(ip route | grep default | awk '{print $3}')"
    echo "RAM_TOTAL = $(free -m | awk '/Mem:/{printf "%.3f GB", $2/1024}')"
    echo "RAM_USED = $(free -m | awk '/Mem:/{printf "%.3f GB", $3/1024}')"
    echo "RAM_FREE = $(free -m | awk '/Mem:/{printf "%.3f GB", $4/1024}')"
    echo "SPACE_ROOT = $(df /root/ | awk '/\/$/ {printf "%.2f MB", $2/1024}')"
    echo "SPACE_ROOT_USED = $(df /root/ | awk '/\/$/ {printf "%.2f MB", $3/1024}')"
    echo "SPACE_ROOT_FREE = $(df /root/ | awk '/\/$/ {printf "%.2f MB", $4/1024}')"
}

main

read -p "Do you want to save this?(Y/y)" answer

if [ "$answer" = "Y" ] || [ "$answer" = "y" ]
then
	current_date=$(date "+%d_%m_%y_%H_%M_%S")
	filename="$current_date.status"
	main >> $filename
	echo "file saved!"
fi
