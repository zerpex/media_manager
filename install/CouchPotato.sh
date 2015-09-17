#!/bin/bash
# This script installs Sarakha63's fork of CouchPotato.
# 

echo "=============================="
echo "    Installing CouchPotato"
echo "------------------------------"

echo " "
echo " "
echo " Cloning git repository..."
sudo mkdir -p /opt/couchpotato
sudo git clone https://github.com/sarakha63/CouchPotatoServer.git /opt/couchpotato

echo " "
echo " "
echo " Create config file and launcher..."
sudo cp /opt/couchpotato/init/ubuntu /etc/init.d/couchpotato
sudo cp startup_scripts/couchpotato.default /etc/default/couchpotato
sudo chmod +x /etc/init.d/couchpotato

echo " "
echo " "
echo " Give www-data access rights on files..."
sudo mkdir -p /var/run/couchpotato
sudo chown www-data:www-data /etc/default/couchpotato
sudo chown -R www-data:www-data /var/run/couchpotato
sudo chown -R www-data:www-data /opt/couchpotato

echo " "
echo " "
echo " Start Couchpotato automatically when server start..."
sudo update-rc.d couchpotato defaults

echo " "
echo " "
echo "Turning services on..."
sudo service couchpotato start

echo "OK. CouchPotato installed and running."

cpid=`sudo cat /var/run/couchpotato/couchpotato.pid`
cport=`sudo netstat -nap | grep LISTEN | grep $cpid | awk '{ print $4 }' | awk -F: '{ print $2 }'`
done+=(couchpotato)