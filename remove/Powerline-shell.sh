#!/bin/bash
# This script installs Powerline-shell.
# 

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
cp powerline-shell.py ~
cp powerline-shell.py /home/$user
sudo chown $user:$user /home/$user/powerline-shell.py

echo " "
echo " "
echo " Adding required commands to root .bashrc..."
sudo echo " " >> ~/.bashrc
sudo echo "PS1=\"[e[1;33m][ u[e[1;37m]@[e[1;32m]h[e[1;33m] W\$(git branch 2> /dev/null | grep -e '* ' | sed 's/^..(.*)/ {[e[1;36m]1[e[1;33m]}/') ][e[0m]n==> \"" >> ~/.bashrc
sudo echo "function _update_ps1()" >> ~/.bashrc
sudo echo "{" >> ~/.bashrc
sudo echo "export PS1=\"\$(~/powerline-shell.py \$?)\"" >> ~/.bashrc
sudo echo "}" >> ~/.bashrc
sudo echo "export PROMPT_COMMAND=\"_update_ps1\"" >> ~/.bashrc

echo " "
echo " "
echo " Adding required commands to root .bash_profile..."
sudo echo " " >>  ~/.bash_profile
sudo echo "if [[ -f .bashrc ]]" >> ~/.bash_profile
sudo echo "then" >> ~/.bash_profile
sudo echo ". ./.bashrc" >> ~/.bash_profile
sudo echo "fi" >> ~/.bash_profile
sudo echo "BASH_ENV=~./bashrc" >> ~/.bash_profile
sudo echo "export BASH_ENV" >> ~/.bash_profile

echo " "
echo " "
echo " Adding required commands to $user's .bashrc..."
sudo echo " " >> ~/.bashrc
sudo echo "PS1=\"[e[1;33m][ u[e[1;37m]@[e[1;32m]h[e[1;33m] W\$(git branch 2> /dev/null | grep -e '* ' | sed 's/^..(.*)/ {[e[1;36m]1[e[1;33m]}/') ][e[0m]n==> \"" >> /home/$user/.bashrc
sudo echo "function _update_ps1()" >> /home/$user/.bashrc
sudo echo "{" >> /home/$user/.bashrc
sudo echo "export PS1=\"\$(~/powerline-shell.py \$?)\"" >> /home/$user/.bashrc
sudo echo "}" >> /home/$user/.bashrc
sudo echo "export PROMPT_COMMAND=\"_update_ps1\"" >> /home/$user/.bashrc
sudo chown $user:$user /home/$user/.bashrc

echo " "
echo " "
echo " Adding required commands to $user's .bash_profile..."
sudo echo " " >>  /home/$user/.bash_profile
sudo echo "if [[ -f .bashrc ]]" >> /home/$user/.bash_profile
sudo echo "then" >> /home/$user/.bash_profile
sudo echo ". ./.bashrc" >> /home/$user/.bash_profile
sudo echo "fi" >> /home/$user/.bash_profile
sudo echo "BASH_ENV=~./bashrc" >> /home/$user/.bash_profile
sudo echo "export BASH_ENV" >> /home/$user/.bash_profile
sudo chown $user:$user /home/$user/.bash_profile
	
echo "OK. Powerline installed and running."
done+=(powerline)