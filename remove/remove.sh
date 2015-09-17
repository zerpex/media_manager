#!/bin/bash
# This script automatically install some services to any debian based distro.

ip=`ifconfig eth0 | sed -n 2p | awk -F: '{print $2'} | awk '{print $1'}`
user=`whoami`
done=""

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
    "1")source remove/DNSmasq.sh;;
    "2")source remove/SickRage.sh;;
    "3")source remove/uBooquity.sh;;
    "4")source remove/CouchPotato.sh;;
    "5")source remove/HeadPhones.sh;;
    "6")source remove/Maraschino.sh;;
    "7")source remove/Powerline-shell.sh;;
    "8")sudo rm /etc/nginx/sites-available/reverse
	sudo services nginx restart;;
    [rR] | [r|R])source media_manager.sh;;
    [qQ] | [q|Q])exit;;
     * )  echo "invalid option";;
    esac
    sleep 1
done
