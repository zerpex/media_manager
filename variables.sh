#!/bin/bash
#
# This file presents all variables. This is where you define all options.
#
# Author	: zerpex
# Last update	: 2015-09-18

BCKPATH="media_manager.20150917/backup/confs"					# Backup path. Default is "backup/saves"

################
# Apps specific

# Couchpotato
CPUSER=www-data                                                                 # User to use for starting.
CPGROUP=www-data                                                                # Group to use for starting.
CPPATH="/opt/couchpotato"                                                       # Couchpotato install path. Default is "/opt/couchpotato"
CPDATA="/opt/couchpotato/data"                                                  # Data user path (databases, conf...). Default is "/opt/couchpotato"
CPPORT="42003"                                                                  # Port to access app through your browser. Default is "42003"
CPWEB="movies"                                                                  # Reverse URL to access app through your browser. Apply only if nginx is installed. Default is "/movies/"

# Headphones
HPUSER=www-data                                                                 # User to use for starting.
HPGROUP=www-data                                                                # Group to use for starting.
HPPATH="/opt/headphones"                                                        # Headphones install path. Default is "/opt/headphones"
HPDATA="/opt/headphones/data"                                                   # Data user path (databases, conf...). Default is "/opt/headphones"
HPPORT="42004"                                                                  # Port to access app through your browser. Default is "42004"
HPWEB="music"                                                                   # Reverse URL to access app through your browser. Apply only if nginx is installed. Default is "/music/"

# Maraschino
MSPATH="/opt/maraschino"							# Maraschino install path. Default is "/opt/maraschino"	
MSUSER=www-data									# User to use for starting.
MSPORT="42000"									# Port to access app through your browser. Default is "42000"
MSWEB=""									# Reverse URL to access app through your browser. Apply only if nginx is installed. Default is "/"

# Sickrage
SRUSER=www-data									# User to use for starting.
SRGROUP=www-data								# Group to use for starting.
SRPATH="/opt/sickrage"								# Install path. Default is "/opt/sickrage"	
SRDATA="/opt/sickrage/data"							# Data user path (databases, conf...). Default is "/opt/sickrage"
SRPORT="42001"									# Port to access app through your browser. Default is "42001"
SRWEB="tv"									# Reverse URL to access app through your browser. Apply only if nginx is installed. Default is "/tv/"

# Transmission
TRUSER=$CUSER                                                                   # User to use for starting.
TRGROUP=debian-transmission                                                     # Group to use for starting.
TRPATH="/opt/transmission"                                                      # Install path. Default is "/opt/transmission"
TRDATA="/home/$TRUSER"                                                          # Data user path (databases, conf...). Default is "/home/www-data"
TRPORT="42005"                                                                  # Port to access app through your browser. Default is "42005"
TRWEB="tr"                                                                      # Reverse URL to access app through your browser. Apply only if nginx is installed. Default is "/tr/"

# uBooquity
UBUSER=www-data									# User to use for starting.
UBGROUP=www-data								# Group to use for starting.
UBPATH="/opt/ubooquity"								# uBooquity install path. Default is "/opt/ubooquity"	
UBDATA="/opt/ubooquity/data"							# uBooquity user path (databases, conf...). Default is "/opt/ubooquity"
UBPORT="42002"									# Port to access app through your browser. Default is "42002"
UBWEB="bd"									# Reverse URL to access app through your browser. Apply only if nginx is installed. Default is "/bd/"
UBRAM=512m									# RAM allocated to ubooquity's jvm. Default is 512m

################
# Other variables 
# Don't change them unless you know exactly what you are doing

IP=`ifconfig eth0 | sed -n 2p | awk -F: '{print $2'} | awk '{print $1'}`        # IP of the current server.
CUSER=`whoami`                                                                  # Current user.
DATEJOUR=$(date +"%Y%m%d-%H%M")                                                 # Current date.

#--- Define text colors
CSI="\033["
CEND="${CSI}0m"
CRED="${CSI}1;31m"
CGREEN="${CSI}1;32m"
CYELLOW="${CSI}1;33m"
CBLUE="${CSI}1;34m"

echo -e "${CYELLOW} Adding current user in all app groups...$CEND"
sudo usermod -a -G $SRGROUP $CUSER
sudo usermod -a -G $UBGROUP $CUSER
sudo usermod -a -G $CPGROUP $CUSER
sudo usermod -a -G $HPGROUP $CUSER
