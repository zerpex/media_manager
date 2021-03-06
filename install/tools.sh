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
               zer's automated tools installer
    ----------------------------------------------------------
    Please enter your choice:

    (1) DNS with ad-blocker
    (2) Powerline-shell

    (0) Install ALL tools

           (R)eturn to main menu
           (Q)uit
    ----------------------------------------------------------
EOF
    read -n1 -s
    case "$REPLY" in
    "1")source install/DNSmasq.sh;;
    "2")source install/Powerline-shell.sh;;
    "0")source install/DNSmasq.sh
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
