#!/bin/bash
# This script removes Powerline-shell.
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
echo -e "${CRED}   Removing Powerline-shell$CEND"
echo -e "${CBLUE}-----------------------------$CEND"
echo " "
echo -e "${CYELLOW} Removing files...$CEND"
sudo rm /root/powerline-shell.py
sudo rm /home/$user/powerline-shell.py

echo -e "${CYELLOW} Restoring .bash_profile and .bashrc files...$CEND"
sudo mv /root/.bashrc.oriz /root/.bashrc
sudo mv /root/.bash_profile.oriz /root/.bash_profile

sudo mv /home/$CUSER/.bashrc.oriz /home/$CUSER/.bashrc
sudo mv /home/$CUSER/.bash_profile.oriz /home/$CUSER/.bash_profile
	
echo -e "${CRED}OK. Powerline-shell removed.$CEND" 
