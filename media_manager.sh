#!/bin/bash
# Media manager
#
# This script automatically manage some services to any debian based distro.
#
# author       : zer ( cg.cpam@gmail.com )
# Last updated : 2015 09 14
# Version 1.1
#
# Changelog
# v 1.1
# - Split original script in multiple ones. That way it is easier to manage.
# - Add confs backup options
#
# v 1.0
# - Original script.

#  includes
INCLUDES="./"
. "$INCLUDES"variables.sh

if [ ! -f /etc/debian_version ];
then
	echo " This script has been writen for Debian-based distros."
	exit 0
fi

while :
do
    clear
    cat<<EOF
    ==============================================================
               Media managers softwares scripts utility
    --------------------------------------------------------------
    Please enter your choice:

    (1) Install Tools
    (2) Install Medias manager's Apps
    (3) Install Seedbox Apps (NOT READY YET)

    (4) Backup apps configurations
    (5) Restore apps configurations (NOT READY YET)

    (6) Remove apps
	
    (7) Upgrade the system
    (8) Backup server global configuration
    (9) Restore server global configuration
    
           (Q)uit
    ---------------------------------------------------------------
EOF
    read -n1 -s
    case "$REPLY" in
    "1")source install/tools.sh;;
    "2")source install/medias.sh;;
    "3")#source install/seedbox.sh;;
        source media_manager.sh;;
    "4")source backup/save_conf.sh;;
    "5")source media_manager.sh;;
    "6")source remove/remove.sh;;
    "7")echo "Upgrading the system..."
        apt-get -y upgrade ;;
    "8")source backup/save_global_conf.sh;;
    "9")source backup/restore_global_conf.sh;;
    [qQ] | [q|Q])exit;;
    esac
    sleep 1
done
