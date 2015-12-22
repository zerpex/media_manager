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
REPBACKUP="$REPENCOURS/backup/$server/apps/$DATEJOUR"

#  includes
INCLUDES="./"
. "$INCLUDES"variables.sh

mkdir -p $REPBACKUP

if [ -d $SRPATH ];
then
        echo " "
        sudo service sickrage stop
		sleep 2
		sudo killall sickrage
        echo " Saving SickRage's configuration..."
        sudo mkdir -p $REPBACKUP/sickrage/data
        sudo cp -r $SRDATA $REPBACKUP/sickrage/data/
        sudo cp $SRPATH/config.ini $REPBACKUP/sickrage/
        sudo service sickrage start
fi

if [ -d $MSPATH ];
then
        echo " "
        sudo service maraschino stop
		sleep 2
		sudo killall maraschino
        echo " Saving Maraschino's configuration..."
        sudo mkdir -p $REPBACKUP/maraschino
        sudo cp $MSPATH/maraschino.db $REPBACKUP/maraschino/
        sudo service maraschino start
fi

if [ -d $UBPATH ];
then
        echo " "
        sudo service ubooquity stop
		sleep 2
		sudo killall ubooquity
        echo " Saving uBooquity's configuration..."
        sudo mkdir -p $REPBACKUP/ubooquity/data
        sudo cp -r $UBPATH $REPBACKUP/ubooquity/
        sudo cp -r $UBDATA $REPBACKUP/ubooquity/data/
        sudo cp /etc/init.d/ubooquity $REPBACKUP/ubooquity/
        sudo service ubooquity start
fi

if [ -d $CPPATH ];
then
        echo " "
        sudo service couchpotato stop
		sleep 2
		sudo killall couchpotato
        echo " Saving CouchPotato's configuration..."
        sudo mkdir -p $REPBACKUP/couchpotato/data
        sudo cp -r $CPDATA $REPBACKUP/couchpotato/data/
        sudo service couchpotato start
fi

if [ -d $HPPATH ];
then
        echo " "
        sudo service headphones stop
		sleep 2
		sudo killall headphones
        echo " Saving HeadPhones's configuration..."
        sudo mkdir -p $REPBACKUP/headphones/data
        sudo cp -r $HPDATA $REPBACKUP/headphones/data/
        sudo cp $HPPATH/config.ini $REPBACKUP/headphones/
        sudo service headphones start
fi

echo -e "Data are backed up in $REPBACKUP."
