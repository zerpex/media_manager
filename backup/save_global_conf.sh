#!/bin/sh
# This script saves global server's configuration

server=`cat /etc/hostname`
user=`whoami`

mkdir -p confs/$server/global

echo " "
echo " Saving hostname..."
sudo cp /etc/hostname confs/$server/global/

echo " Saving bashrc..."
sudo cp /etc/bash.bashrc confs/$server/global/
sudo cp /home/$user/.bashrc confs/$server/global/$user.bashrc
sudo cp /root/.bashrc confs/$server/global/root.bashrc

echo " Saving .profile..."
sudo cp /home/$user/.profile confs/$server/global/$user.profile
sudo cp /root/.profile confs/$server/global/root.profile

echo " Saving networking..."
sudo cp /etc/network/interfaces confs/$server/global/

echo " Saving fstab..."
sudo cp /etc/fstab confs/$server/global/

echo " Saving localtime..."
sudo cp /etc/localtime confs/$server/global/

sudo echo $user > confs/$server/global/original_user