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

    (1) Install apps
    (2) Backup configurations of installed apps
    (3) Remove apps
	
    (4) Upgrade the system
    (5) Backup server global configuration
    (6) Restore server global configuration
    
           (Q)uit
    ---------------------------------------------------------------
EOF
    read -n1 -s
    case "$REPLY" in
    "1")source install/install.sh;;
	"2")source backup/save_conf.sh;;
	"3")source backup/restore_conf.sh;;
	"4")echo "Upgrading the system..."
        apt-get -y upgrade ;;
	"5")source backup/save_global_conf.sh;;
	"6")source backup/restore_global_conf.sh;;
	[qQ] | [q|Q])exit;;
    esac
    sleep 1
done
