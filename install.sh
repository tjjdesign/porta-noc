#!/bin/bash
# PORTA NOC PRE-PRODUCTION
clear
head -10 readme.md

#Log install actions
if (test -f "install.latest"); then
    cat install.latest >> install.log
    rm install.latest
    exec > >(tee -i install.latest)
else
    exec > >(tee -i install.latest)
fi

#date for log
printf "\n"
date

#Check for sudo
if [[ $EUID -ne 0 ]]; then
    printf "This installer must be run as root.\n"
    exit 1
fi

#Check/Install required network tools/firewall
printf "# Verifiying network requirments are met. #\n"

#Checking for internet/DNS connectivity
printf "Checking for internet connectivity..."
sleep 1
if ping -q -c 1 -W 1 google.com >/dev/null; then
  echo "SUCCESS"
  sleep 1
else
  echo "FAIL"
  printf "\nNo internet connectivity.\n"
  sleep 1
  exit 1
fi

#List interfaces
printf "These are your current network interfaces.\n"
ifconfig -a | sed 's/[ \t].*//;/^$/d'
sleep 1

#select upstream internet connection
echo -n "Type the name of the interface that will host the internet connection. "
read HOSTIF
echo "You have selected "
printf $HOSTIF + " adapter information: \n"
ifconfig $HOSTIF | grep 'inet'
echo
#(Will add more options/selection choices here as installs require)

#Install splunk


#Install greylog


#Install moloch/kismet/ettercap/bettercap


echo "Complete."
sleep 2