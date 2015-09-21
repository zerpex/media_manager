!! Ce script est écrit pour les distributions basées sur Debian !!

Ayant fais pas mal de tests ces derniers mois avec plusieurs appareils et en ayant eu marre de tout installer à la main à chaque fois, j'ai fini par écrire un script pour automatiser l'installation de plusieurs softs :
- DNSmasq + filtres ad-block
- Sickrage : pour les séries TV
- uBooquity : pour la gestion des BDs, Comics, eBooks...
- Couchpotato : pour les films
- Headphones : pour la musique
- Maraschino : tableau de bord pour gérer tout ça
- Powerline-shell : pour avoir un prompt tout joli :)

Changelog :
v.1.2 (21/09/2015)
- Ré-écriture complète des scripts d'installation et de suppression :
   - Passage d'un max de choses en variables
   - Edition automatique des confs en fonction des variables
- Remplacement des forks de Sarakha63 par les versions officielles de Couchpotato et Headphones.
- Headphones répond maintenant aux requêtes du réseau entier (et non plus en localhost uniquement).

 v.1.1 (17/09/2015) 
- Passage de SickRage et Headphones sur les versions officielles.
- Éclatement du script en plusieurs pour gagner en modularité.
- Contrôle du système d'exploitation.
- Backup des confs et bases des apps supportées.
- Backup des principaux fichiers systèmes (hostname, réseau...).
- Restauration des fichiers systèmes.
- Suppression des apps

v1.0 (16/09/2015)
-Version originale.

A faire :
Pas encore de restauration des confs et bases des apps atm. Le script fait la sauvegarde, mais il faut restaurer à la main wink

Procédure :
- clonez le git : 
	git clone https://github.com/zerpex/media_manager.git 
- Ci-besoin : personnalisez les options d"installation : 
	vi variables.sh
- Exécutez le script principal : 
	sudo ./media_manager.sh
- Choisissez ce que vous voulez faire via le menu et laissez le travailler !

Chemins d'accès par défaut :
Maraschino : http://xxx.xxx.xxx.xxx:42000
SickRage : http://xxx.xxx.xxx.xxx:42001/tv
uBooquity : http://xxx.xxx.xxx.xxx:42002/bd
Couchpotato : http://xxx.xxx.xxx.xxx:42003/movies
Headphones : http://xxx.xxx.xxx.xxx:42004/music
xxx.xxx.xxx.xxx étant l'adresse IP de votre serveur.
