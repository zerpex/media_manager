#!/bin/bash
# This script automatically install some services to any debian based distro.

echo " "
echo " Installing prerequisites..."
#--- If last apt-get update is older than 30mn, redo.
if [ "$[$(date +%s) - $(stat -c %Z /var/cache/apt)]" -ge 1800 ]
then
	sudo apt-get update
fi
sudo apt-get -y install sudo curl git unzip

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
    (4) ChouchPotato
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
    [rR] | [r|R])echo " "
        echo "=============================="
        echo "  Important notes :"
        echo "------------------------------"
        echo " "
        case "$done" in
            "adblock")echo "  - Add $IP as your main DNS server for Ad-blocker to work.";;
            "sickrage")echo "  - SickRage is available from http://$IP:$SRPORT";;
			"ubooquity")echo "  - uBooquity is available from http://$IP:$UBPORT";;
			"couchpotato")echo "  - Couchpotato is available from http://$IP:$CPPORT";;
			"headphones")echo "  - Headphones is available from http://$IP:$HPPORT/$HPWEB";;
			"maraschino")echo "  - Maraschino is available from http://$IP:$MSPORT";;
			"powerline")echo "  - Add a Powerline type font to your terminal. check https://github.com/powerline/fonts";;
	esac
	done=""
        echo " "
		source media_manager.sh;;
    [qQ] | [q|Q])echo " "
                echo "=============================="
                echo "  Important notes :"
                echo "------------------------------"
                echo " "
            case "$done" in
                        "adblock")echo "  - Add $IP as your main DNS server for Ad-blocker to work.";;
                        "sickrage")echo "  - SickRage is available from http://$IP:$SRPORT";;
                        "ubooquity")echo "  - uBooquity is available from http://$IP:$UBPORT";;
                        "couchpotato")echo "  - Couchpotato is available from http://$IP:$CPPORT";;
                        "headphones")echo "  - Headphones is available from http://$IP:$HPPORT/$HPWEB";;
                        "maraschino")echo "  - Maraschino is available from http://$IP:$MSPORT";;
                        "powerline")echo "  - Add a Powerline type font to your terminal. check https://github.com/powerline/fonts";;
                esac
        echo " "
	done=""
        exit;;
     * )  echo "invalid option"     ;;
    esac
    sleep 1
done
