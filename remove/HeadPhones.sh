#!/bin/bash
# This script removes Sarakha63's fork of CouchPotato.
# 

echo "=============================="
echo "    Removing HeadPhones"
echo "------------------------------"
echo " "
echo " "
echo "Turning services off..."
sudo service headphones stop

echo " Removing HeadPhones files..."
sudo rm -R /opt/headphones

echo " Removing config files and launcher..."
sudo rm /etc/init.d/headphones
sudo rm /etc/default/headphones
sudo rm -R /var/run/headphones

echo " Remove HeadPhones automatic startup..."
sudo update-rc.d headphones remove

echo " "
echo "OK. HeadPhones removed."