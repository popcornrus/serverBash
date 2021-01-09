#!/bin/bash

clear

# Colors of output
ERROR='\033[0;31m'
SUCCESS='\033[0;32m'
WARNING='\033[1;33m'
NC='\033[0;0m'

domainName=''
serverRoot="/srv/${domainName}"

# Check if user login as root
if [ "$(whoami)" != "root" ]; then
	echo "Need root access.\nEnter 'sudo -s' to login as root user."
	exit;
fi

# Enter root path to web server
read -p "Enter new domain: " domainName
read -p "Enter Document root path: " documentRoot

if [ "$(node scripts/js/addNewDomain.js ${domainName} ${documentRoot})" == "false" ]; then
	printf "${ERROR}This domain exists!${NC}\n"
	exit;
fi

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

a2ensite "${domainName}"
if ! systemctl restart apache2; then
	printf "${ERROR} Hmm... Something went wrong!"
fi
echo "127.0.0.1 ${domainName}" >> /etc/hosts

ftpPassword=$(node scripts/js/functions.js change-password)

read -p "Enter username for FTP access: " ftpUser
useradd -m -c "${ftpUser}" -s /bin/bash ${ftpUser}
usermod -p "${ftpPassword}" ${ftpUser}

userAccess="
#FTP\n
Host:\t\t\t$(wget -qO- eth0.me)\n
Port:\t\t\t21\n
Username:\t\t${ftpUser}\n
Password:\t\t${ftpPassword}\n\n

#DB
Host:\t\t\t127.0.0.1
Username\t\t
"


