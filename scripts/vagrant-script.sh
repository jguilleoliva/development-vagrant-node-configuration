#!/bin/bash
cd /tmp
#--- SETUP
echo "##--- CONFIGURE TERMINAL ---#"
sudo sed -i '/la/c\alias la="ls -lAhXG --color=always"' ~/.bashrc
echo "##--- END:CONFIGURE TERMINAL ---#"
echo "##--- UPDATE SYSTEM ---#"
apt-get -qq update
apt-get -y upgrade
echo "##--- END:UPDATE SYSTEM ---#"
echo "##--- CONFIGURE-TIMEZONE ---#"
sudo timedatectl set-timezone America/Guatemala
echo "##--- END:CONFIGURE-TIMEZONE ---#"
#--- !SETUP
#--- ESSENTIALS
echo "##--- INSTALL-ESSENTIALS ---#"
sudo apt-get -y install wget git vim curl build-essential software-properties-common multitail
echo "##--- END:INSTALL-ESSENTIALS ---#"
#--- !ESSENTIALS
#--- APACHE2
echo "##--- INSTALL-APACHE ---#"
sudo apt-get -y install apache2
sudo a2enmod rewrite
sudo sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
sudo systemctl restart apache2
echo "##--- END:INSTALL-APACHE ---#"
#--- !APACHE2
#--- MYSQL
echo "##--- INSTALL-MYSQL ---#"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password 0000"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password 0000"
sudo apt-get -y install mysql-server 
	#--- CREATE DEVELOPMENT DATABASE
	mysql -uroot -p0000 -e "CREATE DATABASE FRAMEWORK_DATABASE CHARACTER SET UTF8 COLLATE utf8_bin"
	mysql -uroot -p0000 -e "CREATE USER 'FRAMEWORK_USER' IDENTIFIED BY '0000'"
	mysql -uroot -p0000 -e "GRANT ALL PRIVILEGES ON *.* TO 'FRAMEWORK_USER'@'%' WITH GRANT OPTION"
	mysql -uroot -p0000 -e "USE mysql"
	mysql -uroot -p0000 -e "UPDATE user SET plugin='mysql_native_password' WHERE User='root'"
	mysql -uroot -p0000 -e "FLUSH PRIVILEGES"
	#--- !CREATE DEVELOPMENT DATABASE
echo "##--- END:INSTALL-MYSQL ---#"
#--- !MYSQL
#--- PHP
echo "##--- INSTALL-PHP7 ---#"
sudo apt-get install -y php libapache2-mod-php php-common php-curl php-gd php-imagick php-imap php-intl php-json php-oauth php-mysql php-soap php-cli
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_WARNING \& ~E_DEPRECATED/" /etc/php/7.4/apache2/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.4/apache2/php.ini
sudo sed -i "s|;extension=mysqli|extension=mysqli|" /etc/php/7.4/apache2/php.ini
sudo sed -i "s|;date.timezone =|date.timezone = America\/Guatemala|" /etc/php/7.4/apache2/php.ini
sudo sed -i "s|DirectoryIndex .*|DirectoryIndex index.html index.php|" /etc/apache2/mods-enabled/dir.conf
sudo systemctl restart apache2
echo "##--- END:INSTALL-PHP7 ---#"
#--- !PHP
echo "##--- ALL-DONE ---##"
