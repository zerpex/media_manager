#!/bin/bash
# This script installs Maraschino.
#
# Author        : zerpex
# Last update   : 2015-09-21

#  includes
INCLUDES="./"
. "$INCLUDES"variables.sh

clear
echo " "
echo " "
echo -e "${CBLUE}=============================$CEND"
echo -e "${CGREEN}     Installing Maraschino$CEND"
echo -e "${CBLUE}-----------------------------$CEND"
echo " "
echo -e "${CYELLOW} Cloning git repository...$CEND"
sudo mkdir -p $MSPATH
sudo git clone https://github.com/mrkipling/maraschino.git $MSPATH

echo " "
GREPOUT=`grep $MSUSER /etc/passwd`
if [ "$GREPOUT" == "" ]
then
    echo " "
	echo "${CRED}   User does not exist. Do you want to create it (y/n) ?$END"
    read GO
    if [ "$GO" == "y" ]
    then
		read -s -p "Enter password : " password
		egrep "^$MSUSER" /etc/passwd >/dev/null
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		sudo useradd -m -p $pass $MSUSER
		[ $? -eq 0 ] && echo "${CGREEN}  User has been added to system!$END" || echo -e "${CRED}  Failed to add user!$END" ; exit 1; }
		sudo useradd -G $MSGROUP $MSUSER || { echo -e $RED'Adding $MSGROUP group to $MSUSER failed.'$END ; exit 1; }
    fi
else
    echo " "
	echo "${CGREEN}   User already exists. Nothing changed...$END"
fi

echo -e "${CYELLOW} Create config file and launcher...$CEND"
sudo cp $MSPATH/initd /etc/init.d/maraschino
sudo cp $MSPATH/default /etc/default/maraschino
sudo chmod +x /etc/init.d/maraschino

sudo sed -i 's/APP_PATH=\/opt\/maraschino/APP_PATH='"$MSPATH"'/g' /etc/init.d/maraschino
sudo sed -i 's/RUN_AS=www-data/RUN_AS='"$MSUSER"'/g' /etc/init.d/maraschino
sudo sed -i 's/PORT=7000/PORT='"$MSPORT"'/g' /etc/init.d/maraschino
sudo sed -i 's/#WEBROOT=\/maraschino/WEBROOT=\/'"$MSWEB"'/g' /etc/init.d/maraschino

echo " "
echo -e "${CYELLOW} Start HeadPhones automatically when server start...$CEND"
sudo update-rc.d maraschino defaults


echo " "
echo -e "${CYELLOW} Turning services on...$CEND"
sudo service maraschino start

echo "maraschino" >> installed_apps.txt

echo -e "${CGREEN} OK. Maraschino installed and running at http://$IP:$TRPORT $CEND"
pause 'Press [Enter] key to continue...'
