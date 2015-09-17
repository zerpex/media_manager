#!/bin/bash
# restore server's conf

printf "Please select server's conf to be restored :\n"
select server in */; do test -n "$d" && break; echo ">>> Invalid Selection"; done

user=`whoami`
user_ori=`cat confs/$server/global/original_user`

echo " "
echo " Restoring hostname..."
sudo mv /etc/hostname /etc/hostname.ori
sudo cp confs/$server/global/hostname /etc/

echo " Restoring bashrc..."
sudo mv /etc/bash.bashrc /etc/bash.bashrc.ori
sudo mv /home/$user/.bashrc /home/$user/.bashrc/ori
sudo mv /root/.bashrc /root/.bashrc.ori
sudo cp confs/$server/global/bash.bashrc /etc/
sudo cp confs/$server/global/$user_ori.bashrc /home/$user/.bashrc 
sudo cp confs/$server/global/root.bashrc /root/.bashrc 
sudo chown $user:$user /home/$user/.bashrc 

echo " Restoring .profile..."
sudo mv /home/$user/.profile /home/$user/.profile.ori
sudo mv /root/.profile /root/.profile.ori
sudo cp confs/$server/global/$user_ori.profile /home/$user/.profile
sudo cp confs/$server/global/root.profile /root/.profile 
sudo chown $user:$user /home/$user/.profile

echo " Restoring networking..."
sudo mv /etc/network/interfaces /etc/network/interfaces.ori
sudo cp confs/$server/global/interfaces /etc/network/

echo " Restoring fstab..."
sudo mv /etc/fstab /etc/fstab.ori
sudo cp confs/$server/global/fstab /etc/

echo " Restoring shared folders..."
sudo grep media /etc/fstab | awk '{ print $2 }' | xargs -r mkdir -p
sudo grep mnt /etc/fstab | awk '{ print $2 }' | xargs -r mkdir -p
echo " Mounting shared folders..."
sudo grep media /etc/fstab | awk '{ print $2 }' | xargs -r mount
sudo grep mnt /etc/fstab | awk '{ print $2 }' | xargs -r mount

echo " Restoring localtime..."
sudo mv /etc/localtime /etc/localtime.ori
sudo cp confs/$server/global/localtime /etc/ 