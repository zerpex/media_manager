#!/bin/bash
# This script removes SickRage.
#
# Author        : zerpex
# Last update   : 2015-09-21


#  includes
INCLUDES="./"
. "$INCLUDES"variables.sh

clear
echo " "
echo " "
echo -e "${CBLUE}=============================$CEND"
echo -e "${CRED}     Removing SickRage$CEND"
echo -e "${CBLUE}-----------------------------$CEND"
echo " "
echo -e "${CYELLOW} Turning services off...$CEND"
sudo service sickrage stop

echo -e "${CYELLOW} Removing SickRage files...$CEND"
sudo rm -R $SRPATH
sudo rm -R $SRDATA

echo -e "${CYELLOW} Removing config files and launcher...$CEND"
sudo rm /etc/init.d/sickrage
sudo rm /etc/default/sickrage
sudo rm -R /var/run/sickrage

echo -e "${CYELLOW} Remove SickRage automatic startup...$CEND"
sudo update-rc.d sickrage remove

echo " "
echo -e "${CRED}OK. SickRage removed.$CEND"
