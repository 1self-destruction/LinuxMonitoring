#!/bin/bash
. ./supp.sh

if [[ -n $5 ]]
then
    echo "too much arguments"
else
    if [[ -n $4 ]]
    then
        reg="^[1-6]$"

	if [[ $1 =~ $reg ]] && [[ $2 =~ $reg ]] && [[ $3 =~ $reg ]] && [[ $4 =~ $reg ]]
	then
	    if [[ $1 == $2 ]] || [[ $3 == $4 ]]
	    then
		echo "arguments (1-2) (3-4) cannot be equal. Please try again."
	    else
    		HOSTNAME=$(hostname)
		TIMEZONE="$(cat /etc/timezone) $(date -u "+%Z") $(date "+%z")"
    		USER=$(whoami)
    		OS=$(cat /etc/issue | awk '{print $1,$2,$3}' | tr -s '\r\n' ' ')
    		DATE=$(date "+%d %b %Y %H:%M:%S")
    		UPTIME=$(uptime -p)
    		UPTIME_SEC=$(cat /proc/uptime | awk '{print $1}')
    		IP=$(wget -qO- eth0.me)
    		MASK=$(ifconfig | grep -m1 netmask | awk '{print $4}')
    		GATEWAY=$(ip route | grep default | awk '{print $3}')
    		RAM_TOTAL=$(free -m | awk '/Mem:/{printf "%.3f GB", $2/1024}')
    		RAM_USED=$(free -m | awk '/Mem:/{printf "%.3f GB", $3/1024}')
    		RAM_FREE=$(free -m | awk '/Mem:/{printf "%.3f GB", $4/1024}')
    		SPACE_ROOT=$(df /root/ | awk '/\/$/ {printf "%.2f MB", $2/1024}')
    		SPACE_ROOT_USED=$(df /root/ | awk '/\/$/ {printf "%.2f MB", $3/1024}')
    		SPACE_ROOT_FREE=$(df /root/ | awk '/\/$/ {printf "%.2f MB", $4/1024}')

		get_color $1
		left_back_color="\033[4$?m"
		get_color $2
		left_text_color="\033[3$?m"
		get_color $3
		right_back_color="\033[4$?m"
		get_color $4
		right_text_color="\033[3$?m"
		default_colors="\033[37m\033[0m"

		print_color
	fi
    else
	echo "arguments should be 1-6"
    fi
  else
	echo "not enough arguments"
    fi
fi
