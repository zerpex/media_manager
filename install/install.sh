#!/bin/bash
# This script automatically install some services to any debian based distro.

ip=`ifconfig eth0 | sed -n 2p | awk -F: '{print $2'} | awk '{print $1'}`
user=`whoami`

echo " "
echo " Installing prerequisites..."
sudo apt-get update
sudo apt-get -y install curl git python-cheetah python3-lxml htop locate unzip

while :
do
    clear
    cat<<EOF
    ==========================================================
               zer's automated services installer
    ----------------------------------------------------------
    Please enter your choice:

    (1) DNS with ad-blocker            
    (2) SickRage   
    (3) uBooquity
    (4) ChouchPotato (sarakha63's fork)
    (5) HeadPhones  
    (6) Maraschino   
    (7) Powerline-shell

    (0) Install ALL apps ( for fresh server install )
    
           (R)eturn to main menu
           (Q)uit
    ----------------------------------------------------------
EOF
    read -n1 -s
    case "$REPLY" in
    "1")source install/DNSmasq.sh;;
    "2")source install/SickRage.sh;;
    "3")source install/uBooquity.sh;;
    "4")source install/CouchPotato.sh;;
    "5")source install/HeadPhones.sh;;
    "6")source install/Maraschino.sh;;
    "7")source install/Powerline-shell.sh;;
	"0")source install/DNSmasq.sh
        source install/SickRage.sh
        source install/uBooquity.sh
        source install/CouchPotato.sh
        source install/HeadPhones.sh
        source install/Maraschino.sh
        source install/Powerline-shell.sh;;
    [rR] | [r|R])source media_manager.sh;;
    [qQ] | [q|Q])echo " "
		echo "=============================="
		echo "  Important notes :"
		echo "------------------------------"
		echo " "
	    case "$done" in
			"adblock")echo "  - Add $ip as your main DNS server for Ad-blocker to work.";;
			"sickrage")echo "  - SickRage is available from http://$ip:$sport";;
			"ubooquity")echo "  - uBooquity is available from http://$ip:2022";;
			"couchpotato")echo "  - Couchpotato is available from http://$ip:$cport";;
			"headphones")echo "  - Headphones is available from http://$ip:$hport";;
			"maraschino")echo "  - Maraschino is available from http://$ip:7000";;
			"powerline")echo "  - Add a Powerline type font to your terminal";;
		esac
	echo " "
	exit;;
     * )  echo "invalid option"     ;;
    esac
    sleep 1
done
