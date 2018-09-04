#!/bin/bash
cd /tmp
#--- SETUP
echo "##--- UPDATE SYSTEM ---#"
apt-get -qq update
apt-get -y upgrade
echo "##--- END:UPDATE SYSTEM ---#"
#--- !SETUP
#--- ESSENTIALS
echo "##--- INSTALL-ESSENTIALS ---#"
sudo apt-get -y install wget git vim curl build-essential software-properties-common
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
	mysql -uroot -p0000 -e "CREATE DATABASE FRAMEWORK_DATABASE"
	mysql -uroot -p0000 -e "grant all privileges on FRAMEWORK_DATABASE.* to 'FRAMEWORK_USER'@'localhost' identified by '0000'"
	#--- !CREATE DEVELOPMENT DATABASE
echo "##--- END:INSTALL-MYSQL ---#"
#--- !MYSQL
#--- PHP
echo "##--- INSTALL-PHP ---#"
sudo apt-get install -y php libapache2-mod-php php-common php-curl php-gd php-imagick php-imap php-intl php-json php-oauth php-mysql php-gettext php-soap php-cli
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_WARNING \& ~E_DEPRECATED/" /etc/php/7.2/apache2/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.2/apache2/php.ini
sudo sed -i "s|;date.timezone =|date.timezone = America\/Guatemala|" /etc/php/7.2/apache2/php.ini
sudo sed -i "s|DirectoryIndex .*|DirectoryIndex index.html index.php|" /etc/apache2/mods-enabled/dir.conf
sudo systemctl restart apache2
echo "##--- END:INSTALL-PHP ---#"
#--- !PHP

echo "##--- ALL-DONE ---##"