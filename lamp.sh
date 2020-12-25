#!/bin/bash

# Colors
ERROR="\033[0;31m"
SUCCESS="\033[0;32m"
NC="\033[0;0m"

NULLDEV="> /dev/null 2>&1"

clear
if [ "$(whoami)" != 'root' ]; then
	printf "${ERROR}You need to sign in as Root user: sudo {file}\n"
fi

printf "Install all packages? (y/n): "
read installAll

if [[ "${installAll}" == 'y' ]]; then
	printf "Update packages list: "
	if apt-get update > /dev/null 2>&1; then
		printf "${SUCCESS}Success${NC}\n"
	fi

	printf "Install Apache2 packages: "
	if apt-get -y install apache2 > /dev/null 2>&1; then
		printf "${SUCCESS}Success${NC}\n\n"
	fi

	printf "What DBMS you want?\n1. MySQL\n2.MariaDB\nWrite here number: "
	read dbms
	if [ "${dbms}" == 1 ]; then
		printf "Install MySQL DBMS: "
		if apt-get -y install mysql-server > /dev/null 2>&1; then
			printf "${SUCCESS}Success${NC}\n"
		fi
	else
		printf "Install MariaDB DBMS: "
		if apt-get -y install mariadb-server > /dev/null 2>&1; then
			printf "${SUCCESS}Success${NC}\n"
		fi
	fi

	printf "\nInstalling PHP: "
	if apt-get -y install php libapache2-mod-php php-mysql > /dev/null 2>&1; then
		printf "${SUCCESS}Success${NC}\n"
		
		printf "Install standart modules to PHP? (y/n): "
		read phpModules

		if [ "${phpModules}" == "y" ]; then
			printf "Start installing PHP Modules: "
			if apt-get -y install php-curl php-json php-cgi php-gd php-zip php-mbstring php-xml php-xmlrpc > /dev/null 2>&1; then
				printf "${SUCCESS}Success${NC}\n"
			fi		
		fi
	fi

	printf "\nInstall packages to use FTP? (y/n): "
	read installFTP

	if [ "${installFTP}" == "y" ]; then
		printf "Installing vsFTPd packages: "
		if apt-get -y install vsftpd > /dev/null 2>&1; then
			systemctl enable vsftpd
			printf "Setting up ports to connect by FTP: 21\n"
			ufw allow 21/tcp > /dev/null 2>&1
		fi
	fi

	printf "\nInstall phpMyAdmin? (y/n): "
	read phpMyAdmin

	if [ "${phpMyAdmin}" == 'y' ]; then
		if apt-get -y install phpmyadmin; then
			printf "phpMyAdmin installed ${SUCCESS}Succesfully${NC}\n"
		fi
	fi
fi
