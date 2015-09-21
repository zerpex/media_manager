#!/bin/bash
# This script removes uBooquity.
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
echo -e "${CRED}     Removing uBooquity$CEND"
echo -e "${CBLUE}-----------------------------$CEND"
echo " "
echo -e "${CYELLOW} Turning services off...$CEND"
sudo service ubooquity stop

echo -e "${CYELLOW} Removing uBooquity files...$CEND"
sudo rm -R $UBPATH
sudo rm -R $UBDATA

echo -e "${CYELLOW} Removing config files and launcher...$CEND"
sudo rm /etc/init.d/ubooquity
sudo rm /etc/default/ubooquity
sudo rm -R /var/run/ubooquity

echo -e "${CYELLOW} Remove uBooquity automatic startup...$CEND"
sudo update-rc.d ubooquity remove

echo -e "${CRED}OK. uBooquity removed.$CEND"
