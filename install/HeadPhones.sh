#!/bin/bash
# This script installs HeadPhones.
#
# Author        : zerpex
# Last update   : 2015-09-18

#  includes
INCLUDES="./"
. "$INCLUDES"variables.sh

clear
echo " "
echo " "
echo -e "${CBLUE}=============================$CEND"
echo -e "${CGREEN}     Installing HeadPhones$CEND"
echo -e "${CBLUE}-----------------------------$CEND"
echo " "
echo -e "${CYELLOW} Cloning git repository...$CEND"
sudo mkdir -p /opt/headphones
sudo git clone https://github.com/rembo10/headphones.git $HPPATH

echo " "
echo -e "${CYELLOW} Create config file and launcher...$CEND"
#--- startup file installation
sudo cp /opt/headphones/init-scripts/init.ubuntu /etc/init.d/headphones
sudo chmod +x /etc/init.d/headphones
#--- default file generation
sudo echo "HP_USER=$HPUSER" > startup_scripts/headphones.default
sudo echo "HP_GROUP=$HPGROUP" >> startup_scripts/headphones.default
sudo echo "HP_HOME=$HPPATH" >> startup_scripts/headphones.default
sudo echo "HP_DATA=$HPPATH" >> startup_scripts/headphones.default
sudo echo "HP_OPTS=\" --config=$HPPATH/config.ini\"" >> startup_scripts/headphones.default
sudo cp startup_scripts/headphones.default /etc/default/headphones

echo " "
echo -e "${CYELLOW} Give www-data access rights on files...$CEND"
sudo mkdir -p /var/run/headphones
sudo chown -R $HPUSER:$HPGROUP /var/run/headphones
sudo chown -R $HPUSER:$HPGROUP $HPPATH

echo " "
echo -e "${CYELLOW} Start HeadPhones automatically when server start...$CEND"
sudo update-rc.d headphones defaults

echo " "
echo -e "${CYELLOW} Start/stop HeadPhones in order to generate config files...$CEND"
sudo service headphones start
sleep 5
sudo service headphones stop
sleep 2

echo " "
echo -e "${CYELLOW} Updating HeadPhones' configuration...$CEND"
sudo sed -i 's/http_port = 8181/http_port = '"$HPPORT"'/g' $HPDATA/config.ini
sudo sed -i 's/http_root = \//http_root = '"$HPWEB"'\//g' $HPDATA/config.ini
sudo sed -i 's/http_host = localhost/http_host = 0.0.0.0/g' $HPDATA/config.ini

echo " "
echo -e "${CYELLOW} Turning services on...$CEND"
sudo service headphones start
HPPID=`sudo cat /var/run/headphones/headphones.pid`
done+=(headphones)

echo -e "${CGREEN} OK. HeadPhones installed and running with pid $HPPID.$CEND"

