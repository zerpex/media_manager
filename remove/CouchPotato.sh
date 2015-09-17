#!/bin/bash
# This script removes Sarakha63's fork of CouchPotato.
# 

echo "=============================="
echo "    Removing CouchPotato"
echo "------------------------------"
echo " "
echo " "
echo "Turning services off..."
sudo service couchpotato stop

echo " Removing Couchpotato files..."
sudo rm -R /opt/couchpotato

echo " Removing config files and launcher..."
sudo rm /etc/init.d/couchpotato
sudo rm /etc/default/couchpotato
sudo rm -R /var/run/couchpotato

echo " Remove Couchpotato automatic startup..."
sudo update-rc.d couchpotato remove

echo " "
echo "OK. CouchPotato removed."