apt-get -y purge apache2 mysql-server mariadb-server libapache2-mod-php php-mysql php-curl php-json php-cgi php-gd php-zip php-mbstring php-xml php-xmlrpc vsftpd phpmyadmin > /dev/null 2>&1

printf "Deleting all installed packages to LAMP server\n"

apt-get -y autoremove > /dev/null 2>&1
