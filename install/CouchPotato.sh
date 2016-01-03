#!/bin/bash
# This script installs Couchpotato.
#
# Author	: zerpex
# Last update	: 2015-09-21

#  includes
INCLUDES="./"
. "$INCLUDES"variables.sh

clear
echo " "
echo " "
echo -e "${CBLUE}=============================$CEND"
echo -e "${CGREEN}     Installing Couchpotato$CEND"
echo -e "${CBLUE}-----------------------------$CEND"
echo " "
echo -e "${CYELLOW} Installing pre-requsites...$CEND"
sudo apt-get -y install python python-cheetah python-mako python-lxml python-openssl python3-lxml python3-openssl

echo " "
echo -e "${CYELLOW} Cloning git repository...$CEND"
sudo mkdir -p $CPPATH
sudo git clone https://github.com/RuudBurger/CouchPotatoServer $CPPATH

GREPOUT=`grep $CPUSER /etc/passwd`
if [ "$GREPOUT" == "" ]
then
    echo " "
	echo "${CRED}   User does not exist. Do you want to create it (y/n) ?$END"
    read GO
    if [ "$GO" == "y" ]
    then
		read -s -p "Enter password : " password
		egrep "^$CPUSER" /etc/passwd >/dev/null
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		sudo useradd -m -p $pass $CPUSER
		[ $? -eq 0 ] && echo "${CGREEN}  User has been added to system!$END" || { echo -e "${CRED}  Failed to add user!$END" ; exit 1; }
		sudo useradd -G $CPGROUP $CPUSER || { echo -e $RED'Adding $CPGROUP group to $CPUSER failed.'$END ; exit 1; }
    fi
else
    echo " "
	echo "${CGREEN}   User already exists. Nothing changed...$END"
fi

echo " "
echo -e "${CYELLOW} Create config file and launcher...$CEND"
#--- startup file installation
sudo cp $CPPATH/init/ubuntu /etc/init.d/couchpotato
sudo chmod +x /etc/init.d/couchpotato
#--- default file generation
sudo echo "CP_USER=$CPUSER" > startup_scripts/couchpotato.default
sudo echo "CP_GROUP=$CPGROUP" >> startup_scripts/couchpotato.default
sudo echo "CP_HOME=$CPPATH" >> startup_scripts/couchpotato.default
sudo echo "CP_DATA=$CPDATA" >> startup_scripts/couchpotato.default
sudo cp startup_scripts/couchpotato.default /etc/default/couchpotato
sudo chown $SRUSER /etc/default/couchpotato

echo " "
echo -e "${CYELLOW} Give www-data access rights on files...$CEND"
sudo mkdir -p /var/run/couchpotato
sudo chown $CPUSER:$CPGROUP /etc/default/couchpotato
sudo chown -R $CPUSER:$CPGROUP /var/run/couchpotato
sudo chown -R $CPUSER:$CPGROUP $CPPATH

echo " "
echo -e "${CYELLOW} Start/stop Couchpotato in order to generate config files...$CEND"
sudo service couchpotato start
sleep 5
sudo service couchpotato stop
sleep 2

echo " "
echo -e "${CYELLOW} Updating Couchpotato's configuration...$CEND"
sudo sed -i 's/port = 5050/port = '"$CPPORT"'/g' $CPDATA/settings.conf || { echo -e $RED'Replacing port failed.'$END ; pause; }
sudo sed -i 's/url_base =/url_base = '"$CPWEB"'/g' $CPDATA/settings.conf || { echo -e $RED'Replacing web url failed.'$END ; pause; }

echo " "
echo -e "${CYELLOW} Start Couchpotato automatically when server start...$CEND"
sudo update-rc.d couchpotato defaults

echo " "
echo -e "${CYELLOW} Turning services on...$CEND"
sudo service couchpotato start
CPPID=`sudo cat /var/run/couchpotato/couchpotato.pid`
echo "couchpotato" >> installed_apps.txt

echo -e "${CGREEN} OK. Couchpotato installed and running at http://$IP:$CPPORT$CPWEB $CEND"
pause 'Press [Enter] key to continue...'
