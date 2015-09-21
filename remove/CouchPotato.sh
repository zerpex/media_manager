#!/bin/bash
# This script removes Couchpotato.
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
echo -e "${CRED}     Removing Couchpotato$CEND"
echo -e "${CBLUE}-----------------------------$CEND"
echo " "

echo -e "${CYELLOW} Turning services off...$CEND"
sudo service couchpotato stop

echo -e "${CYELLOW} Removing Couchpotato files...$CEND"
sudo rm -R $CPPATH
sudo rm -R $CPDATA

echo -e "${CYELLOW} Removing config files and launcher...$CEND"
sudo rm /etc/init.d/couchpotato
sudo rm /etc/default/couchpotato
sudo rm -R /var/run/couchpotato

echo -e "${CYELLOW} Remove Couchpotato automatic startup...$CEND"
sudo update-rc.d couchpotato remove

echo " "
echo -e "${CRED} OK. CouchPotato removed.$CEND"
