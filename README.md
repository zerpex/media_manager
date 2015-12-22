# media_manager
Automated installation of media managing softs on debian based distros

These scripts were made to help people who wants a bunch of softs designed to manage their media files.
Included softs are :

<i>Media management apps :</i>
- Sickrage : for TV Shows
- uBooquity : for Comics, eBooks, pdfs...
- Couchpotato : for movies
- Headphones : for music
- Maraschino : dashboard

<i>Tools :</i>
- DNSmasq + ad-block filters
- Powerline-shell : for a beautifull prompt :)

<i>Seedbox apps :</i>
- Transmission
- ruTorrent (INC)
- Seedbox Manager (INC)

<b>How to use :</b>
- Clone repository :<br>
<i>git clone https://github.com/zerpex/media_manager.git </i>

- Have a look at variables.sh in order to change options<br>
<i>vi variables.sh</i>

- Launch the scrip :<br>
<i>sudo ./media_manager.sh</i>

- Follow the menus :)

<b>Default access URLs :</b><br>
Maraschino : http://xxx.xxx.xxx.xxx:42000<br>
SickRage : http://xxx.xxx.xxx.xxx:42001/tv<br>
uBooquity : http://xxx.xxx.xxx.xxx:42002/bd<br>
Couchpotato : http://xxx.xxx.xxx.xxx:42003/movies<br>
Headphones : http://xxx.xxx.xxx.xxx:42004/music<br>
Transmission : http://xxx.xxx.xxx.xxx:42005/tr<br>
xxx.xxx.xxx.xxx is the default IP adress of your serveur.

To do :
- ruTorrent install/remove script
- Seedbox manager install/remove script
- HTPC Manager install/remove script
- Transmission remove script
- nginx with reverse conf
