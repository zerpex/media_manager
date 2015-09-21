#!/bin/bash
# This script installs DNSmasq with ad-block filters.
# Originally writen by jacobsalmela for raspbian.
#
# Author	: jacobsalmela
# Adapted by: zerpex
# Last update	: 2015-09-21

#  includes
INCLUDES="./"
. "$INCLUDES"variables.sh

clear
echo " "
echo " "
echo -e "${CBLUE}=============================$CEND"
echo -e "${CGREEN}     Installing DNSmasq$CEND"
echo -e "${CBLUE}-----------------------------$CEND"

echo " "
echo -e "${CYELLOW} Installing DNS...$CEND"
sudo apt-get -y install dnsutils dnsmasq

echo " "
echo -e "${CYELLOW} Installing a Web server$CEND"
sudo apt-get -y install lighttpd
sudo mkdir -p /var/www
sudo chown www-data:www-data /var/www
sudo chmod 775 /var/www
sudo usermod -a -G www-data $CUSER

echo " "
echo -e "${CYELLOW} Stopping services to modify them...$CEND"
sudo service dnsmasq stop
sudo service lighttpd stop

echo " "
echo -e "${CYELLOW} Backing up original config files and downloading Pi-hole ones...$CEND"
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
sudo mv /etc/lighttpd/lighttpd.conf /etc/lighttpd/lighttpd.conf.orig
sudo mv /var/www/index.lighttpd.html /var/www/index.lighttpd.orig
sudo curl -o /etc/dnsmasq.conf "https://raw.githubusercontent.com/jacobsalmela/pi-hole/master/advanced/dnsmasq.conf"
sudo curl -o /etc/lighttpd/lighttpd.conf "https://raw.githubusercontent.com/jacobsalmela/pi-hole/master/advanced/lighttpd.conf"
sudo mkdir -p /var/www/pihole
sudo curl -o /var/www/pihole/index.html "https://raw.githubusercontent.com/jacobsalmela/pi-hole/master/index.html"

echo " "
echo -e "${CYELLOW} Turning services back on...$CEND"
sudo service dnsmasq start
sudo service lighttpd start

echo " "
echo -e "${CYELLOW} Locating the Pi-hole...$CEND"
sudo curl -o /usr/local/bin/gravity.sh "https://raw.githubusercontent.com/jacobsalmela/pi-hole/master/gravity-adv.sh"
sudo chmod 755 /usr/local/bin/gravity.sh
echo -e "${CYELLOW} Entering the event horizon...$CEND"
sudo /usr/local/bin/gravity.sh

echo " "
echo -e "${CYELLOW} Restarting services...$CEND"
sudo service dnsmasq restart
sudo service lighttpd restart

echo " "
echo -e "${CYELLOW} Add job to crontab to update ad-lists every nights...$CEND"
line="2 15 * * * /usr/local/bin/gravity.sh"
(sudo crontab -u root -l; sudo echo "$line" ) | sudo crontab -u root -
done+=(adblock)

echo -e "${CGREEN} OK. DNS whith ad-blocker installed.$CEND"
