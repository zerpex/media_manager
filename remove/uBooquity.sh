#!/bin/bash
# This script installs uBooquity.
# 

echo "=============================="
echo "    Removing uBooquity"
echo "------------------------------"
echo " "
echo " "
echo "Turning services off..."
sudo service ubooquity stop

echo " Removing uBooquity files..."
sudo rm -R /opt/ubooquity
sudo rm -R /usr/local/ubooquity
sudo rm /etc/init.d/ubooquity

echo " Remove uBooquity automatic startup..."
sudo update-rc.d ubooquity remove

echo "OK. uBooquity removed."
done+=(ubooquity)
