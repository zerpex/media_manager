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
echo -e "${CYELLOW} Installing pre-requsites...$CEND"
sudo apt-get -y install python python-cheetah python-mako python-lxml python-openssl python3-lxml python3-openssl

echo " "
echo -e "${CYELLOW} Cloning git repository...$CEND"
sudo mkdir -p $HPPATH
sudo git clone https://github.com/rembo10/headphones.git $HPPATH

GREPOUT=`grep $HPUSER /etc/passwd`
if [ "$GREPOUT" == "" ]
then
    echo " "
	echo "${CRED}   User does not exist. Do you want to create it (y/n) ?$END"
    read GO
    if [ "$GO" == "y" ]
    then
		read -s -p "Enter password : " password
		egrep "^$HPUSER" /etc/passwd >/dev/null
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		sudo useradd -m -p $pass $HPUSER
		[ $? -eq 0 ] && echo "${CGREEN}  User has been added to system!$END" || echo -e "${CRED}  Failed to add user!$END" ; exit 1; }
		sudo useradd -G $HPGROUP $HPUSER || { echo -e $RED'Adding $HPGROUP group to $HPUSER failed.'$END ; exit 1; }
    fi
else
    echo " "
	echo "${CGREEN}   User already exists. Nothing changed...$END"
fi

echo " "
echo -e "${CYELLOW} Create config file and launcher...$CEND"
#--- startup file installation
sudo cp $HPPATH/init-scripts/init.ubuntu /etc/init.d/headphones
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
echo "headphones" >> installed_apps.txt

echo -e "${CGREEN} OK. Headphones installed and running at http://$IP:$HPPORT $CEND"
pause 'Press [Enter] key to continue...'

