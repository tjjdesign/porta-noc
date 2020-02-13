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
else
  echo "FAIL"
  printf "\nNo internet connectivity.\n"
  exit 1
fi

#Install splunk

#Install greylog

#Install moloch/kismet/ettercap/bettercap

echo "Complete."
sleep 2