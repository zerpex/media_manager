#!/bin/bash
# This script removes Sarakha63's fork of SickRage.
# 

echo "=============================="
echo "    Removing SickRage"
echo "------------------------------"
echo " "
echo " "
echo "Turning services off..."
sudo service sickrage stop

echo " Removing SickRage files..."
sudo rm -R /opt/sickrage

echo " Removing config files and launcher..."
sudo rm /etc/init.d/sickrage
sudo rm /etc/default/sickrage
sudo rm -R /var/run/sickrage

echo " Remove SickRage automatic startup..."
sudo update-rc.d sickrage remove

echo " "
echo "OK. SickRage removed."