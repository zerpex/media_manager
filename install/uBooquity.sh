#!/bin/bash
# This script installs uBooquity.
# 

echo "=============================="
echo "    Installing uBooquity"
echo "------------------------------"

echo " "
echo " "
echo " Installing pre-requsites (Java 8)..."
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
sudo apt-get update
sudo apt-get install oracle-java8-installer -y

echo " "
echo " "
echo " Create config file and launcher..."
sudo mkdir -p /opt/ubooquity
sudo mkdir -p /usr/local/ubooquity
cd /opt/ubooquity

echo " "
echo " "
echo " Downloading latest version..."
sudo wget "http://vaemendis.net/ubooquity/service/download.php" -O ubooquity.zip && sudo unzip ubooquity*.zip && sudo rm ubooquity*.zip
sudo cp startup_scripts/ubooquity /etc/init.d/
sudo chmod +x /etc/init.d/ubooquity

echo " "
echo " "
echo " Give www-data access rights on files..."
sudo chown -R www-data /opt/ubooquity
sudo chown -R www-data /usr/local/ubooquity

echo " "
echo " "
echo " Start uBooquity automatically when server start..."
sudo update-rc.d ubooquity defaults

echo " "
echo " "
echo "Turning services on..."
sudo service ubooquity start

echo "OK. uBooquity installed and running."
done+=(ubooquity)