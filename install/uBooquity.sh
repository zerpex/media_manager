#!/bin/bash
# This script installs uBooquity.
#
# Author	: zerpex
# Last update	: 2015-12-22

#  includes
INCLUDES="./"
. "$INCLUDES"variables.sh

clear
echo " "
echo " "
echo -e "${CBLUE}=============================$CEND"
echo -e "${CGREEN}     Installing uBooquity$CEND"
echo -e "${CBLUE}-----------------------------$CEND"
echo " "
JAVA8=`dpkg -l |grep java8 | awk '{ print $2 }'`
if [ "JAVA8" != "oracle-java8-installer" ]
then
	echo -e "${CYELLOW} Adding Java8 repository...$END"
	GREPOUT=$(grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep webupd8team)
	if [ "$GREPOUT" == "" ]; then
		echo -e "${CYELLOW} Installing pre-requsites (Java 8)...$CEND"
		echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
		echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
		sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
		echo -e "${CYELLOW} Refreshing list again...$END"
		sudo apt-get update
	else
		echo "${CRED}   Java8 repository already exists. Nothing added...$END"
	fi
	echo "${CYELLOW} Installing Java8...$END"
	echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
	echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
	sudo apt-get install -y oracle-java8-installer
fi

GREPOUT=`grep $UBUSER /etc/passwd`
if [ "$GREPOUT" == "" ]
then
    echo " "
	echo "${CRED}   User does not exist. Do you want to create it (y/n) ?$END"
    read GO
    if [ "$GO" == "y" ]
    then
		read -s -p "Enter password : " password
		egrep "^$UBUSER" /etc/passwd >/dev/null
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		sudo useradd -m -p $pass $UBUSER
		[ $? -eq 0 ] && echo "${CGREEN}  User has been added to system!$END" || echo -e "${CRED}  Failed to add user!$END" ; exit 1; }
		sudo useradd -G $UBGROUP $UBUSER || { echo -e $RED'Adding $UBGROUP group to $UBUSER failed.'$END ; exit 1; }
    fi
else
    echo " "
	echo "${CGREEN}   User already exists. Nothing changed...$END"
fi
	
echo " "
echo -e "${CYELLOW} Create config file and launcher...$CEND"
sudo mkdir -p $UBPATH
sudo mkdir -p $UBDATA

echo " "
echo -e "${CYELLOW} Downloading latest version...$CEND"
sudo wget "http://vaemendis.net/ubooquity/service/download.php" -O $UBPATH/ubooquity.zip
sudo unzip $UBPATH/ubooquity*.zip -d $UBPATH
sudo rm $UBPATH/ubooquity*.zip

echo " "
echo -e "${CYELLOW} Create config file and launcher...$CEND"
#--- startup file installation
sudo cp startup_scripts/ubooquity /etc/init.d/
sudo chmod +x /etc/init.d/ubooquity
#--- default file generation
sudo echo "UB_USER=$UBUSER" > startup_scripts/ubooquity.default
sudo echo "UB_GROUP=$UBGROUP" >> startup_scripts/ubooquity.default
sudo echo "UB_HOME=$UBPATH" >> startup_scripts/ubooquity.default
sudo echo "UB_DATA=$UBPATH" >> startup_scripts/ubooquity.default
sudo echo "UB_PORT=$UBPORT" >> startup_scripts/ubooquity.default
sudo echo "UB_RAM=$UBRAM" >> startup_scripts/ubooquity.default
sudo cp startup_scripts/ubooquity.default /etc/default/ubooquity
sudo chown $UBUSER /etc/default/ubooquity

echo " "
echo -e "${CYELLOW} Start/stop uBooquity in order to generate config files...$CEND"
sudo service ubooquity start
sleep 5
sudo service ubooquity stop
sleep 2

#--- preferences file update
sudo sed -i 's/<portNumber>2202<\/portNumber>/<portNumber>'"$UBPORT"'<\/portNumber>/g' $UBDATA/preferences.xml
sudo sed -i 's/<reverseProxyPrefix><\/reverseProxyPrefix>/<reverseProxyPrefix>'"$UBWEB"'<\/reverseProxyPrefix>/g' $UBDATA/preferences.xml

echo " "
echo -e "${CYELLOW} Give www-data access rights on files...$CEND"
sudo mkdir -p /var/run/ubooquity
sudo chown -R $UBUSER:$UBGROUP /var/run/ubooquity
sudo chown -R $UBUSER:$UBGROUP $UBPATH
sudo chown -R $UBUSER:$UBGROUP $UBDATA

echo " "
echo -e "${CYELLOW} Start uBooquity automatically when server start...$CEND"
sudo update-rc.d ubooquity defaults

echo " "
echo -e "${CYELLOW} Turning services on...$CEND"
sudo service ubooquity start

echo "ubooquity" >> installed_apps.txt

echo -e "${CGREEN} OK. Ubooquity installed and running at http://$IP:$UBPORT $CEND"
pause 'Press [Enter] key to continue...'
