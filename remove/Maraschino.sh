#!/bin/bash
# This script Removes Maraschino.
# 

echo "=============================="
echo "    removing Maraschino"
echo "------------------------------"

echo " "
echo " "
echo "Turning services off..."
sudo service maraschino stop

echo " Create config file and launcher..."
sudo rm /etc/init.d/maraschino
sudo rm /etc/default/maraschino
sudo rm -R /opt/maraschino

echo " Remove Maraschino automatic startup..."
sudo update-rc.d maraschino remove

echo "OK. Maraschino installed and running."