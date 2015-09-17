#!/bin/bash
# This script installs DNSmasq with ad-block filters.
# Originally writen by jacobsalmela for raspbian.

echo " "
echo " "
echo "Script from jacobsalmela writen for Raspberry Pi"
echo "Adapted by zer for debian"
echo " "
echo " "
echo "Installing DNS..."
sudo apt-get -y install dnsutils dnsmasq

echo " "
echo " "
echo "Installing a Web server"
sudo apt-get -y install lighttpd
mkdir /var/www
sudo chown www-data:www-data /var/www
sudo chmod 775 /var/www
sudo usermod -a -G www-data $user

echo " "
echo " "
echo "Stopping services to modify them..."
sudo service dnsmasq stop
sudo service lighttpd stop

echo " "
echo " "
echo "Backing up original config files and downloading Pi-hole ones..."
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
sudo mv /etc/lighttpd/lighttpd.conf /etc/lighttpd/lighttpd.conf.orig
sudo mv /var/www/index.lighttpd.html /var/www/index.lighttpd.orig
sudo curl -o /etc/dnsmasq.conf "https://raw.githubusercontent.com/jacobsalmela/pi-hole/master/advanced/dnsmasq.conf"
sudo curl -o /etc/lighttpd/lighttpd.conf "https://raw.githubusercontent.com/jacobsalmela/pi-hole/master/advanced/lighttpd.conf"
sudo mkdir /var/www/pihole
sudo curl -o /var/www/pihole/index.html "https://raw.githubusercontent.com/jacobsalmela/pi-hole/master/index.html"

echo " "
echo " "
echo "Turning services back on..."
sudo service dnsmasq start
sudo service lighttpd start

echo " "
echo " "
echo "Locating the Pi-hole..."
sudo curl -o /usr/local/bin/gravity.sh "https://raw.githubusercontent.com/jacobsalmela/pi-hole/master/gravity-adv.sh"
sudo chmod 755 /usr/local/bin/gravity.sh
echo "Entering the event horizon..."
sudo /usr/local/bin/gravity.sh

echo " "
echo " "
echo "Restarting services..."
sudo service dnsmasq restart
sudo service lighttpd restart

echo " "
echo " "
echo "Add job to crontab to update ad-lists every nights..."
line="2 15 * * * /usr/local/bin/gravity.sh"
(sudo crontab -u root -l; sudo echo "$line" ) | sudo crontab -u root -

echo "OK. DNS whith ad-blocker installed."
done+=(adblock)