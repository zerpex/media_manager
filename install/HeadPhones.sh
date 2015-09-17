#!/bin/bash
# This script installs Sarakha63's fork of HeadPhones.
# 

echo "=============================="
echo "    Installing HeadPhones"
echo "------------------------------"

echo " "
echo " "
echo " Cloning git repository..."
sudo mkdir -p /opt/headphones
#sudo git clone https://github.com/sarakha63/headphones.git /opt/headphones
sudo git clone https://github.com/rembo10/headphones.git /opt/headphones

echo " "
echo " "
echo " Create config file and launcher..."
sudo cp /opt/headphones/init-scripts/init.ubuntu /etc/init.d/headphones
sudo cp startup_scripts/headphones.default /etc/default/headphones
sudo chmod +x /etc/init.d/headphones

echo " "
echo " "
echo " Give www-data access rights on files..."
sudo mkdir -p /var/run/headphones
sudo chown www-data /etc/default/headphones
sudo chown -R www-data /var/run/headphones
sudo chown -R www-data /opt/headphones

echo " "
echo " "
echo " Start HeadPhones automatically when server start..."
sudo update-rc.d headphones defaults

echo " "
echo " "
echo "Turning services on..."
sudo service headphones start

echo "OK. HeadPhones installed and running."

hpid=`sudo cat /var/run/headphones/headphones.pid`
hport=`sudo netstat -nap | grep LISTEN | grep $hpid | awk '{ print $4 }' | awk -F: '{ print $2 }'`
done+=(headphones)
