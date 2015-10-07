#!/bin/bash
# This script install Powerline-shell.
#
# Author        : zerpex
# Last update   : 2015-10-07

#  includes
INCLUDES="./"
. "$INCLUDES"variables.sh

echo -e "${CBLUE}==============================$CEND"
echo -e "${CBLUE}  Installing Powerline-shell"
echo -e "${CBLUE}------------------------------$CEND"

echo " "
echo -e "${CYELLOW} Installing prerequisites...$CEND"
sudo apt-get -y install python-pip fontconfig

echo " "
echo -e "${CYELLOW} Cloning repository...$CEND"
pip install --user git+git://github.com/Lokaltog/powerline

echo " "
echo -e "${CYELLOW} Downloading and Installing required fonts...$CEND"
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
sudo mv PowerlineSymbols.otf /usr/share/fonts/
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
sudo fc-cache -vf
git clone https://github.com/Lokaltog/powerline-fonts.git
sudo mv powerline-fonts/ /usr/share/fonts/
sudo fc-cache -vf

echo " "
echo -e "${CYELLOW} Downloading Powerline-shell...$CEND"
git clone https://github.com/milkbikis/powerline-shell
cd powerline-shell
cp config.py.dist config.py
sudo touch /home/root

for USERS in `ls /home`
do
	if [ $USERS = "root" ]
	then
		USERPATH="/root"
	else
		USERPATH="/home/$USERS"
	fi
	cp powerline-shell.py $USERPATH/
	sudo chown $USERS:$USERS $USERPATH/powerline-shell.py

	echo " "
	echo -e "${CYELLOW} Adding required commands to $USERS's .bashrc...$CEND"
	sudo cp $USERPATH/.bashrc $USERPATH/.bashrc.oriz
	sudo echo " " >> $USERPATH/.bashrc
	sudo echo "PS1=\"[e[1;33m][ u[e[1;37m]@[e[1;32m]h[e[1;33m] W\$(git branch 2> /dev/null | grep -e '* ' | sed 's/^..(.*)/ {[e[1;36m]1[e[1;33m]}/') ][e[0m]n==> \"" >> $USERPATH/.bashrc
	sudo echo "function _update_ps1()" >> $USERPATH/.bashrc
	sudo echo "{" >> $USERPATH/.bashrc
	sudo echo "export PS1=\"\$($USERPATH/powerline-shell.py \$?)\"" >> $USERPATH/.bashrc
	sudo echo "}" >> $USERPATH/.bashrc
	sudo echo "export PROMPT_COMMAND=\"_update_ps1\"" >> $USERPATH/.bashrc
	sudo chown $USERS:$USERS $USERPATH/.bashrc

	echo -e "${CYELLOW} Adding required commands to $USERS's .bash_profile...$CEND"
	sudo cp $USERPATH/.bash_profile $USERPATH/.bash_profile.oriz
	sudo echo " " >>  $USERPATH/.bash_profile
	sudo echo "if [[ -f .bashrc ]]" >> $USERPATH/.bash_profile
	sudo echo "then" >> $USERPATH/.bash_profile
	sudo echo ". ./.bashrc" >> $USERPATH/.bash_profile
	sudo echo "fi" >> $USERPATH/.bash_profile
	sudo echo "BASH_ENV=~./bashrc" >> $USERPATH/.bash_profile
	sudo echo "export BASH_ENV" >> $USERPATH/.bash_profile
	sudo chown $USERS:$USERS $USERPATH/.bash_profile
done
sudo rm /home/root

echo -e "${CGREEN} OK. Powerline installed and running.$CEND"
done+=(powerline)
