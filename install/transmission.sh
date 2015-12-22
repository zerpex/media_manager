#!/bin/bash
# This script installs Transmission.
#
# Author        : zerpex
# Last update   : 2015-12-22

#  includes
INCLUDES="./"
. "$INCLUDES"variables.sh

clear
echo " "
echo " "
echo -e "${CBLUE}=============================$CEND"
echo -e "${CGREEN}     Installing Transmission$CEND"
echo -e "${CBLUE}-----------------------------$CEND"
echo " "
echo -e "${CYELLOW} Installing pre-requsites...$CEND"
sudo apt-get -y install python-software-properties

echo " "
echo -e "${CYELLOW} Adding Transmission repository...$END"
GREPOUT=$(grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep transmissionbt)
if [ "$GREPOUT" == "" ]; then
    sudo add-apt-repository -y ppa:transmissionbt/ppa
	echo -e "${CYELLOW} Refreshing list again...$END"
	sudo apt-get update
else
    echo "${CRED}   Transmission PPA repository already exists. Nothing added...$END"
fi

echo " "
echo -e "${CYELLOW} Installing Transmission commandline, and web interface...$CEND"
sudo apt-get -y install transmission-cli transmission-common transmission-daemon

echo " "
echo -e "${CYELLOW} Stoping Transmission temporarily...$CEND"
sudo /etc/init.d/transmission-daemon stop > /dev/null 2>&1 
sleep 2
sudo service transmission-daemon stop > /dev/null 2>&1 
sleep 2
sudo killall transmission-daemon > /dev/null 2>&1 
sleep 2

GREPOUT=`grep $TRUSER /etc/passwd`
if [ "$GREPOUT" == "" ]
then
    echo " "
	echo "${CRED}   User does not exist. Do you want to create it (y/n) ?$END"
    read GO
    if [ "$GO" == "y" ]
    then
		read -s -p "Enter password : " password
		egrep "^$TRUSER" /etc/passwd >/dev/null
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		sudo useradd -m -p $pass $TRUSER
		[ $? -eq 0 ] && echo "${CGREEN}  User has been added to system!$END" || echo -e "${CRED}  Failed to add user!$END" ; exit 1; }
		sudo useradd -G $TRGROUP $TRUSER || { echo -e $RED'Adding $TRGROUP group to $TRUSER failed.'$END ; exit 1; }
    fi
else
    echo " "
	echo "${CGREEN}   User already exists. Nothing changed...$END"
fi

echo " "
echo -e $YELLOW"  Creating download directories..."$END
if [ ! -d "$TRDATA/.config" ]; then
	mkdir $TRDATA/.config
fi
if [ ! -d "$TRDATA/.config/transmission" ];
then
	echo -e 'No previous Transmission configuration files found'
	mkdir $TRDATA/.config/transmission
else
	mv $TRDATA/.config/transmission $TRDATA/.config/transmission_`date '+%m-%d-%Y_%H-%M'` >/dev/null 2>&1
	echo -e 'Existing Transmission configurations were moved to '$CBLUE'$TRDATA/.config/transmission_'`date '+%m-%d-%Y_%H-%M'`$END
	mkdir $TRDATA/.config/transmission
fi
if [ ! -d "$TRDATA/Downloads" ]; then
	mkdir $TRDATA/Downloads
fi
if [ ! -d "$TRDATA/Downloads/transmission" ]; then
	mkdir $TRDATA/Downloads/transmission
fi
if [ ! -d "$TRDATA/Downloads/transmission/incomplete" ]; then
	mkdir $TRDATA/Downloads/transmission/incomplete
fi

echo " "
echo -e 'Following directories created...'
echo -e $BLUE''$TRDATA'/.config/transmission'$END ' - Transmission Settings'
echo -e $BLUE''$TRDATA'/Downloads'$END ' - Watched Folder'
echo -e $BLUE''$TRDATA'/Downloads/transmission'$END ' - Completed Downloads'
echo -e $BLUE''$TRDATA'/Downloads/transmission/incomplete'$END ' - Incomplete Downloads'

sleep 1
echo 

echo " "
echo -e $YELLOW"  Making some configuration changes..."$END
sudo sed -i 's/USER=debian-transmission/USER='$TRUSER'/g' /etc/init.d/transmission-daemon  || { echo -e $RED'Replacing daemon username in init failed.'$END ; exit 1; }
sudo sed -i 's|/var/lib/transmission-daemon/info|'$TRDATA'/.config/transmission|g' /etc/default/transmission-daemon  || { echo -e $RED'Replacing config directory in defualt failed.'$END ; exit 1; }

sleep 1
echo 

echo " "
echo -e $YELLOW"  Copying settings file and setting permissions..."$END
sudo cp $SCRIPTPATH/transmission-initial-settings.json $TRDATA/.config/transmission/settings.json || { echo -e $RED'Initial settings move failed.'$END ; exit 1; }
cd $TRDATA/.config/transmission
sudo chown $TRUSER:$TRGROUP settings.json  || { echo -e $RED'Chown settings.json failed'$END ; exit 1; }
sudo rm /var/lib/transmission-daemon/info/settings.json > /dev/null 2>&1
sudo ln -s $TRDATA/.config/transmission/settings.json /var/lib/transmission-daemon/info/settings.json || { echo -e $RED'Creating settings.json symbolic link failed.'$END ; exit 1; }
sudo chown -R $TRUSER: $TRDATA/Downloads/transmission
sudo chown -R $TRUSER:$TRGROUP $TRDATA/.config/transmission
sudo chmod -R 775 $TRDATA/Downloads/transmission
sudo chmod -R 775 $TRDATA/.config/transmission
sudo chmod -R 775 /var/lib/transmission-daemon
sudo chmod g+s $TRDATA/.config/transmission
sudo chmod g+s $TRDATA/Downloads/transmission

echo
sleep 1

echo " "
echo -e $YELLOW"  Setting up Transmission User, WebUI User and Password..."$END

echo -n 'Set a username for Transmission WebUI and press [ENTER]: '
read TTRUSER
if [ -z "$TTRUSER" ]
   then
   echo -e '    No username entered so setting default username: '$BLUE'transmission'$END
   TTRUSER=transmission
   else 
   echo -e '    WebUI username set to:'$BLUE $TTRUSER $END
fi
sed -i 's|WEBUI_USERNAME|'$TTRUSER'|g' $TRDATA/.config/transmission/settings.json || { echo -e $RED'Setting new username in settings.json failed.'$END ; exit 1; }

echo -n 'Set a password for Transmission WebUI and press [ENTER]: '
read TPASS
if [ -z "$TPASS" ]
   then
   echo -e '    No password entered so setting default password: '$BLUE'transmission'$END
   TPASS=transmission
   else 
   echo -e '    WebUI password set to: '$BLUE$TPASS$END
fi
sed -i 's|WEBUI_PASSWORD|'$TPASS'|g' $TRDATA/.config/transmission/settings.json || { echo -e $RED'Setting new password in settings.json failed.'$END ; exit 1; }
sed -i 's|USER_NAME|'$TRUSER'|g' $TRDATA/.config/transmission/settings.json || { echo -e $RED'Replacing username in settings-json failed.'$END ; exit 1; }

echo 
sleep 1

echo " "
echo -e $YELLOW"  Setting setuid and setgid..."$END
sudo sed -i 's/setuid debian-transmission/setuid '$TRUSER'/g' /etc/init/transmission-daemon.conf  || { echo -e $RED'Replacing setuid failed.'$END ; exit 1; }
sudo sed -i 's/setgid debian-transmission/setgid '$TRGROUP'/g' /etc/init/transmission-daemon.conf  || { echo -e $RED'Replacing setgid failed.'$END ; exit 1; }

echo 
sleep 1

echo " "
echo -e "${CYELLOW} Start Sickrage automatically when server start...$CEND"
sudo update-rc.d transmission-daemon defaults

echo 
sleep 1

echo " "
echo -e $YELLOW"  Starting Transmission..."$END
sudo /etc/init.d/transmission-daemon start >/dev/null 2>&1
kill -s SIGHUP `pidof transmission-daemon` >/dev/null 2>&1

echo 
sleep 1

TRPID=`sudo cat /var/run/sickrage/sickrage.pid`
echo "transmission" >> installed_apps.txt

echo -e "${CGREEN} OK. Transmission installed and running at http://$IP:$TRPORT $CEND"
pause 'Press [Enter] key to continue...'
