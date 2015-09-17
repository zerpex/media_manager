#!/bin/bash
# This script installs DNSmasq with ad-block filters.
# Originally writen by jacobsalmela for raspbian.

echo "=============================="
echo "    Removing DNSmasq"
echo "------------------------------"
echo " "
echo " "
echo "Stopping services to modify them..."
sudo service dnsmasq stop

echo "removing DNSmasq and dnsutils..."
sudo apt-get -y remove dnsutils dnsmasq

echo "Removing files..."
sudo rm /etc/dnsmasq.conf
sudo rm -R /var/www/pihole
sudo rm /usr/local/bin/gravity.sh

echo "Disable cron job that update ad-lists every nights..."
sudo crontab -l | sed "/^[^#].*gravity.sh/s/^/#/" | sudo crontab -u root -

echo " "
echo "OK. DNS whith ad-blocker installed."
done+=(adblock)