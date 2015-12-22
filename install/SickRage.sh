#!/bin/bash
# This script installs SickRage.
#
# Author	: zerpex
# Last update	: 2015-09-18

#  includes
INCLUDES="./"
. "$INCLUDES"variables.sh

clear
echo " "
echo " "
echo -e "${CBLUE}=============================$CEND"
echo -e "${CGREEN}     Installing SickRage$CEND"
echo -e "${CBLUE}-----------------------------$CEND"
echo " "
echo -e "${CYELLOW} Installing pre-requsites...$CEND"
sudo apt-get -y install python python-cheetah python-mako python-lxml python-openssl python3-lxml python3-openssl

echo -e "${CYELLOW} Cloning git repository...$CEND"
sudo mkdir -p $SRPATH
sudo git clone -b master https://github.com/SickRage/SickRage.git $SRPATH

echo " "
echo -e "${CYELLOW} Create config file and launcher...$CEND"
#--- startup file installation
sudo cp $SRPATH/runscripts/init.debian /etc/init.d/sickrage
sudo chmod +x /etc/init.d/sickrage
#--- default file generation
sudo echo "SR_USER=$SRUSER" > startup_scripts/sickrage.default
sudo echo "SR_GROUP=$SRGROUP" >> startup_scripts/sickrage.default
sudo echo "SR_HOME=$SRPATH" >> startup_scripts/sickrage.default
sudo echo "SR_OPTS=\" --config=$SRPATH/config.ini\"" >> startup_scripts/sickrage.default
sudo cp startup_scripts/sickrage.default /etc/default/sickrage
sudo chown $SRUSER /etc/default/ubooquity

echo " "
echo -e "${CYELLOW} Give $SRUSER access rights on files...$CEND"
sudo mkdir -p /var/run/sickrage
sudo chown -R $SRUSER:$SRGROUP /var/run/sickrage
sudo chown -R $SRUSER:$SRGROUP $SRPATH

echo " "
echo -e "${CYELLOW} Start/stop SickRage in order to generate config files...$CEND"
sudo service sickrage start
sleep 5
sudo service sickrage stop
sleep 2

echo " "
echo -e "${CYELLOW} Updating Sickrage's configuration...$CEND"
sudo sed -i 's/web_port = 8081/web_port = '"$SRPORT"'/g' $SRDATA/config.ini || { echo -e $RED'Replacing web port failed.'$END ; pause; }
sudo sed -i 's/web_root = ""\//web_root = "'"$SRWEB"'\/"/g' $SRDATA/config.ini || { echo -e $RED'Replacing web root failed.'$END ; pause; }

echo " "
echo -e "${CYELLOW} Start Sickrage automatically when server start...$CEND"
sudo update-rc.d sickrage defaults

echo " "
echo -e "${CYELLOW} Turning services on...$CEND"
sudo service sickrage start
echo "sickrage" >> installed_apps.txt

echo -e "${CGREEN} OK SickRage installed and running at http://$IP:$SRPORT $CEND"
pause 'Press [Enter] key to continue...'
