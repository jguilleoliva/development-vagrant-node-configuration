#!/bin/bash

cd /tmp
#--- SETUP
apt-get update
apt-get -y upgrade
#--- !SETUP
#--- ESSENTIALS
sudo apt -y install git vim curl build-essential
#--- !ESSENTIALS
#--- APACHE2
sudo apt -y install apache2
sudo a2enmod rewrite
sudo systemctl restart apache2
sudo sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
#--- !APACHE2
#--- MYSQL
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password 0000"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password 0000"
sudo apt -y install mysql-server 
	#--- CREATE DEVELOPMENT DATABASE
	mysql -uroot -p0000 -e "CREATE DATABASE FRAMEWORK_DATABASE"
	mysql -uroot -p0000 -e "grant all privileges on FRAMEWORK_DATABASE.* to 'FRAMEWORK_USER'@'localhost' identified by '0000'"
	#--- !CREATE DEVELOPMENT DATABASE
#--- !MYSQL
#--- PHP
sudo apt install -y php libapache2-mod-php php-common php-curl php-gd php-imagick php-imap php-intl php-json php-mcrypt php-oauth php-mysql php-gettext
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_WARNING \& ~E_DEPRECATED/" /etc/php/7.0/apache2/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/apache2/php.ini
sudo sed -i "s|;date.timezone =|date.timezone = America\/Guatemala|" /etc/php/7.0/apache2/php.ini
sudo systemctl restart apache2
#--- !PHP
