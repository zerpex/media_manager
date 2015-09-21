#!/bin/bash
# This script removes Maraschino.
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
echo -e "${CRED}     Removing Maraschino$CEND"
echo -e "${CBLUE}-----------------------------$CEND"
echo " "
echo -e "${CYELLOW} Turning services off...$CEND"
sudo service maraschino stop

echo -e "${CYELLOW} Removing Maraschino files...$CEND"
sudo rm -R $MSPATH

echo -e "${CYELLOW} Removing config files and launcher...$CEND"
sudo rm /etc/init.d/maraschino
sudo rm /etc/default/maraschino


echo -e "${CYELLOW} Remove Maraschino automatic startup...$CEND"
sudo update-rc.d maraschino remove

echo " "
echo -e "${CRED} OK. Maraschino removed.$CEND"
