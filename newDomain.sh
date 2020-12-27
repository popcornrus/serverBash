#!/bin/bash

clear

# Colors of output
ERROR='\033[0;31m'
SUCCESS='\033[0;32m'
WARNING='\033[1;33m'
NC='\033[0;0m'

domainName=$1
serverRoot="/srv/${domainName}"

# Check if user login as root
if [ "$(whoami)" != "root" ]; then
	echo "Need root access.\nEnter 'sudo -s' to login as root user."
	exit;
fi

# Enter root path to web server
read -p "Enter Document root path: " documentRoot
read -p "Enter admin E-mail: " adminEmail

printf "Creating folder: "
if ! mkdir -p $serverRoot; then
	printf "${ERROR}Folder Exists${NC}\n\n"
else
	mkdir -p $serverRoot/web/$documentRoot && touch $serverRoot/web/$documentRoot/index.php && echo "<?php phpinfo(); ?>" > $serverRoot/web/$documentRoot/index.php
	mkdir -p $serverRoot/logs && touch $serverRoot/logs/access.log && touch $serverRoot/logs/error.log
	touch /etc/apache2/sites-available/$domainName.conf

	printf "${SUCCESS}Folder and files created with status success!${NC}\n\n"
fi

virtualHost="
# VHC for ${domainName}\n
<VirtualHost *:80>\n
	\tServerName ${domainName}\n
	\tServerAlias *.${domainName}\n
	\tServerAdmin ${adminEmail}\n\n
	\tDocumentRoot ${serverRoot}${documentRoot}\n
	\tErrorLog ${serverRoot}/logs/error.log\n
	\tCustomLog ${serverRoot}/access.log combined\n
</VirtualHost>
"

echo $virtualHost > /etc/apache2/sites-available/$domainName.conf

printf "Can I restart Apache2 package to apply changes? (y/n): "
read q

if [[ "${q}" == "y" ]]; then
	a2ensite $domainName
	if ! systemctl apache2 restart; then
		systemctl status apache2
	fi
else
	printf "${WARNING}Okay! If you want to restart server later then write in console: 'systemctl apache2 restart'${NC}\n\n"
fi

printf "Create FTP access to user? (y/n): " 
read q
if [[ "${q}" == "y" ]]; then
	echo "Yohoo";
fi
