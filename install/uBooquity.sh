#!/bin/bash
# This script installs uBooquity.
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
echo -e "${CGREEN}     Installing uBooquity$CEND"
echo -e "${CBLUE}-----------------------------$CEND"
echo " "
JAVA8=`dpkg -l |grep java8 | awk '{ print $2 }'`
if [ "JAVA8" != "oracle-java8-installer"]
then
	echo -e "${CYELLOW} Installing pre-requsites (Java 8)...$CEND"
	echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
	echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
	sudo apt-get update
	sudo apt-get install -y oracle-java8-installer
fi
	
echo " "
echo -e "${CYELLOW} Create config file and launcher...$CEND"
sudo mkdir -p $UBPATH
sudo mkdir -p $UBDATA

echo " "
echo -e "${CYELLOW} Downloading latest version...$CEND"
sudo wget "http://vaemendis.net/ubooquity/service/download.php" -O $UBPATH/ubooquity.zip
sudo unzip $UBPATH/ubooquity*.zip -d /opt/ubooquity/
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

echo -e "${CYELLOW}OK. uBooquity installed and running.$CEND"
done+=(ubooquity)
