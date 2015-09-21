#!/bin/bash

echo " "
echo " "
echo "=========================================================="
echo "                Backing-up apps config"
echo "----------------------------------------------------------"
echo " "

server=`cat /etc/hostname`
DATEJOUR=$(date +"%Y%m%d-%H%M")
REPENCOURS=`pwd`
REPBACKUP="$REPENCOURS/backup/confs/$server/apps/$DATEJOUR"

mkdir -p $REPBACKUP

if [ -d "/opt/sickrage" ]; 
then
	echo " "
	sudo service sickrage stop
	echo " Saving SickRage's configuration..."
	sudo mkdir -p $REPBACKUP/sickrage
	sudo cp /opt/sickrage/sickbeard.db $REPBACKUP/sickrage/
	sudo cp /opt/sickrage/config.ini $REPBACKUP/sickrage/
	sudo cp /opt/sickrage/cache.db $REPBACKUP/sickrage/
	sudo service sickrage start
fi

if [ -d "/opt/maraschino" ]; 
then
	echo " "
	sudo service maraschino stop
	echo " Saving Maraschino's configuration..."
	sudo mkdir -p $REPBACKUP/maraschino
	sudo cp /opt/maraschino/maraschino.db $REPBACKUP/maraschino/
	sudo service maraschino start
fi

if [ -d "/opt/ubooquity" ]; 
then
	echo " "
	sudo service ubooquity stop
	echo " Saving uBooquity's configuration..."
	sudo mkdir -p $REPBACKUP/ubooquity
	sudo cp -r /var/packages/Ubooquity $REPBACKUP/ubooquity/
	sudo cp /etc/init.d/ubooquity $REPBACKUP/ubooquity/
	sudo service ubooquity start
fi

if [ -d "/opt/couchpotato" ]; 
then
	echo " "
	sudo service couchpotato stop
	echo " Saving CouchPotato's configuration..."
	sudo mkdir -p $REPBACKUP/couchpotato
	sudo cp -r /var/opt/couchpotato $REPBACKUP/couchpotato/
	sudo service couchpotato start
fi

if [ -d "/opt/headphones" ]; 
then
	echo " "
	sudo service headphones stop
	echo " Saving HeadPhones's configuration..."
	sudo mkdir -p $REPBACKUP/headphones
	sudo cp /opt/headphones/headphones.db $REPBACKUP/headphones/
	sudo cp -r /opt/headphones/config.ini $REPBACKUP/headphones/
	sudo service headphones start
fi
