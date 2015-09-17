#!/bin/bash
# This script installs Sarakha63's fork of SickRage.
# 

echo " "
echo "============================="
echo "     Installing SickRage"
echo "-----------------------------"
echo " "
echo " "
echo " Cloning git repository..."
sudo mkdir -p /opt/sickrage
#sudo git clone -b master https://github.com/sarakha63/SickRageVF.git /opt/sickrage
sudo git clone -b master https://github.com/SiCKRAGETV/SickRage.git /opt/sickrage

echo " "
echo " Create config file and launcher..."
#sudo cp /opt/sickrage/init.ubuntu /etc/init.d/sickrage
sudo cp /opt/sickrage/runscripts/init.debian /etc/init.d/sickrage
sudo cp startup_scripts/sickrage.default /etc/default/sickrage
sudo chmod +x /etc/init.d/sickrage

echo " "
echo " Give www-data access rights on files..."
sudo chown www-data /etc/default/sickrage
sudo mkdir -p /var/run/sickrage
sudo chown -R www-data /var/run/sickrage
sudo chown -R www-data /opt/sickrage

echo " "
echo " Start Sickrage automatically when server start..."
sudo update-rc.d sickrage defaults

echo " "
echo "Turning services on..."
sudo service sickrage start

echo "OK. SickRage installed and running."

spid=`sudo cat /var/run/sickrage/sickrage.pid`
sport=`sudo netstat -nap | grep LISTEN | grep $spid | awk '{ print $4 }' | awk -F: '{ print $2 }'`

done+=(sickrage)
