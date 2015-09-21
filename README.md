# media_manager
Automated installation of media managing softs on debian based distros

These scripts were made to help people who wants a bunch of softs designed to manage their media files.
Included softs are :

- Sickrage : for TV Shows
- uBooquity : for Comics, eBooks, pdfs...
- Couchpotato : for movies
- Headphones : for music
- Maraschino : dashboard

I also included :
- DNSmasq + ad-block filters
- Powerline-shell : for a beautifull prompt :)

How to use :
- Clone repository :
git clone https://github.com/zerpex/media_manager.git 

- Have a look at variables.sh in order to change options
vi variables.sh

- Launch the scrip :
sudo ./media_manager.sh

- Follow the menus :)

<b>Default access URLs :</b>
Maraschino : http://xxx.xxx.xxx.xxx:42000
SickRage : http://xxx.xxx.xxx.xxx:42001/tv
uBooquity : http://xxx.xxx.xxx.xxx:42002/bd
Couchpotato : http://xxx.xxx.xxx.xxx:42003/movies
Headphones : http://xxx.xxx.xxx.xxx:42004/music

To do :
- nginx with reverse conf
