#!/bin/bash
# This script is the menu for the remove part.
#
# Author        : zerpex
# Last update   : 2015-09-21

#  includes
INCLUDES="./"
. "$INCLUDES"variables.sh

while :
do
    clear
    cat<<EOF
    ==========================================================
               Select the app to remove
    ----------------------------------------------------------
    Please enter your choice:

    (1) DNS with ad-blocker
    (2) SickRage
    (3) uBooquity
    (4) ChouchPotato
    (5) HeadPhones
    (6) Maraschino
    (7) Powerline-shell
    (8) nginx reverse
    
           (R)eturn to main menu
           (Q)uit
    ----------------------------------------------------------
EOF
    read -n1 -s
    case "$REPLY" in
    "1")echo -e "${CYELLOW}You are about to completely remove DNSmasq (app + DATA). Please confim ( y / n ) : $CEND"
	read confirm
	if [ $confirm == "y" ]
	then
		source remove/DNSmasq.sh
	fi
		source remove/remove.sh;;
    "2")echo -e "${CYELLOW}You are about to completely remove SickRage (app + DATA). Please confim ( y / n ) : $CEND"
	read confirm
	if [ $confirm == "y" ]
	then
		source remove/SickRage.sh
	fi
		source remove/remove.sh;;
    "3")echo -e "${CYELLOW}You are about to completely remove uBooquity (app + DATA). Please confim ( y / n ) : $CEND"
	read confirm
	if [ $confirm == "y" ]
	then
		source remove/uBooquity.sh
	fi
		source remove/remove.sh;;
    "4")echo -e "${CYELLOW}You are about to completely remove CouchPotato (app + DATA). Please confim ( y / n ) : $CEND"
	read confirm
	if [ $confirm == "y" ]
	then
		source remove/CouchPotato.sh
	fi
		source remove/remove.sh;;
    "5")echo -e "${CYELLOW}You are about to completely remove HeadPhones (app + DATA). Please confim ( y / n ) : $CEND"
	read confirm
	if [ $confirm == "y" ]
	then
		source remove/HeadPhones.sh
	fi
		source remove/remove.sh;;
    "6")echo -e "${CYELLOW}You are about to completely remove Maraschino (app + DATA). Please confim ( y / n ) : $CEND"
	read confirm
	if [ $confirm == "y" ]
	then
		source remove/Maraschino.sh
	fi
		source remove/remove.sh;;
    "7")echo -e "${CYELLOW}You are about to completely remove Powerline-shell (app + DATA). Please confim ( y / n ) : $CEND"
	read confirm
	if [ $confirm == "y" ]
	then
		source remove/Powerline-shell.sh
	fi
		source remove/remove.sh;;
    "8")echo -e "${CYELLOW}You are about to completely remove reverse proxy settings. Please confim ( y / n ) : $CEND"
	read confirm
	if [ $confirm == "y" ]
	then
		sudo rm /etc/nginx/sites-available/reverse
		sudo services nginx restart
	fi
		source remove/remove.sh;;
    [rR] | [r|R])source media_manager.sh;;
    [qQ] | [q|Q])exit;;
     * )  echo "invalid option";;
    esac
    sleep 1
done
