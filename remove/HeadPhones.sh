#!/bin/bash
# This script removes Headphones.
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
echo -e "${CRED}     Removing Headphones$CEND"
echo -e "${CBLUE}-----------------------------$CEND"
echo " "
echo -e "${CYELLOW} Turning services off...$CEND"
sudo service headphones stop

echo -e "${CYELLOW} Removing Headphones files...$CEND"
sudo rm -R $HPPATH
sudo rm -R $HPDATA

echo -e "${CYELLOW} Removing config files and launcher...$CEND"
sudo rm /etc/init.d/headphones
sudo rm /etc/default/headphones
sudo rm -R /var/run/headphones

echo -e "${CYELLOW} Remove Couchpotato automatic startup...$CEND"
sudo update-rc.d headphones remove

echo " "
echo -e "${CRED} OK. Headphones removed.$CEND"
