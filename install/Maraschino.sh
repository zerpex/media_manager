#!/bin/bash
# This script installs Maraschino.
# 

echo "=============================="
echo "    Installing Maraschino"
echo "------------------------------"

echo " "
echo " "
echo " Cloning git repository..."
sudo mkdir -o /opt/maraschino
sudo git clone https://github.com/mrkipling/maraschino.git /opt/maraschino

echo " "
echo " "
echo " Create config file and launcher..."
sudo cp /opt/maraschino/initd /etc/init.d/maraschino
sudo cp /opt/maraschino/default /etc/default/maraschino
sudo chmod +x /etc/init.d/maraschino


echo " "
echo " "
echo " Start Maraschino automatically when server start..."
sudo update-rc.d maraschino defaults

echo " "
echo " "
echo "Turning services on..."
sudo service maraschino start

echo "OK. Maraschino installed and running."

done+=(maraschino)