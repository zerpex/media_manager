#!/bin/bash
# This script install Powerline-shell.
#
# Author        : zerpex
# Last update   : 2015-09-21

#  includes
INCLUDES="./"
. "$INCLUDES"variables.sh

echo "=============================="
echo "  Installing Powerline-shell"
echo "------------------------------"

echo " "
echo " Installing prerequisites..."
sudo apt-get -y install python-pip fontconfig 

echo " "
echo " "
echo " Cloning repository..."
pip install --user git+git://github.com/Lokaltog/powerline

echo " "
echo " "
echo " Downloading and Installing required fonts..."
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
sudo mv PowerlineSymbols.otf /usr/share/fonts/
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
sudo fc-cache -vf
git clone https://github.com/Lokaltog/powerline-fonts.git
sudo mv powerline-fonts/ /usr/share/fonts/
sudo fc-cache -vf

echo " "
echo " "
echo " Downloading Powerline-shell..."
git clone https://github.com/milkbikis/powerline-shell
cd powerline-shell
cp config.py.dist config.py
python install.py
cp powerline-shell.py /root/
cp powerline-shell.py /home/$CUSER/
sudo chown $CUSER:$CUSER /home/$CUSER/powerline-shell.py

echo " "
echo " "
echo " Adding required commands to root .bashrc..."
sudo cp /root/.bashrc /root/.bashrc.oriz
sudo echo " " >> /root/.bashrc
sudo echo "PS1=\"[e[1;33m][ u[e[1;37m]@[e[1;32m]h[e[1;33m] W\$(git branch 2> /dev/null | grep -e '* ' | sed 's/^..(.*)/ {[e[1;36m]1[e[1;33m]}/') ][e[0m]n==> \"" >> /root/.bashrc
sudo echo "function _update_ps1()" >> /root/.bashrc
sudo echo "{" >> /root/.bashrc
sudo echo "export PS1=\"\$(/root/powerline-shell.py \$?)\"" >> /root/.bashrc
sudo echo "}" >> /root/.bashrc
sudo echo "export PROMPT_COMMAND=\"_update_ps1\"" >> /root/.bashrc

echo " "
echo " "
echo " Adding required commands to root .bash_profile..."
sudo cp /root/.bash_profile /root/.bash_profile.oriz
sudo echo " " >>  /root/.bash_profile
sudo echo "if [[ -f .bashrc ]]" >> /root/.bash_profile
sudo echo "then" >> /root/.bash_profile
sudo echo ". ./.bashrc" >> /root/.bash_profile
sudo echo "fi" >> /root/.bash_profile
sudo echo "BASH_ENV=~./bashrc" >> /root/.bash_profile
sudo echo "export BASH_ENV" >> /root/.bash_profile

echo " "
echo " "
echo " Adding required commands to $CUSER's .bashrc..."
sudo cp /home/$CUSER/.bashrc /home/$CUSER/.bashrc.oriz
sudo echo " " >> /home/$CUSER/.bashrc
sudo echo "PS1=\"[e[1;33m][ u[e[1;37m]@[e[1;32m]h[e[1;33m] W\$(git branch 2> /dev/null | grep -e '* ' | sed 's/^..(.*)/ {[e[1;36m]1[e[1;33m]}/') ][e[0m]n==> \"" >> /home/$CUSER/.bashrc
sudo echo "function _update_ps1()" >> /home/$CUSER/.bashrc
sudo echo "{" >> /home/$CUSER/.bashrc
sudo echo "export PS1=\"\$(/root/powerline-shell.py \$?)\"" >> /home/$CUSER/.bashrc
sudo echo "}" >> /home/$CUSER/.bashrc
sudo echo "export PROMPT_COMMAND=\"_update_ps1\"" >> /home/$CUSER/.bashrc
sudo chown $CUSER:$CUSER /home/$CUSER/.bashrc

echo " "
echo " "
echo " Adding required commands to $CUSER's .bash_profile..."
sudo cp /home/$CUSER/.bash_profile /home/$CUSER/.bash_profile.oriz
sudo echo " " >>  /home/$CUSER/.bash_profile
sudo echo "if [[ -f .bashrc ]]" >> /home/$CUSER/.bash_profile
sudo echo "then" >> /home/$CUSER/.bash_profile
sudo echo ". ./.bashrc" >> /home/$CUSER/.bash_profile
sudo echo "fi" >> /home/$CUSER/.bash_profile
sudo echo "BASH_ENV=~./bashrc" >> /home/$CUSER/.bash_profile
sudo echo "export BASH_ENV" >> /home/$CUSER/.bash_profile
sudo chown $CUSER:$CUSER /home/$CUSER/.bash_profile
	
echo "OK. Powerline installed and running."
done+=(powerline)
