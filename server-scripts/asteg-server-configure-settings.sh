#!/bin/bash
#--- SYSTEM-UPDATES ---#
echo -e "\n\e[94;1m--- ASTEG-SCRIPTS | \e[0mSERVER-INITIALIZATION ---"
echo -e " \n\e[94;1mASTEG-SCRIPTS - STEP 01 | \e[0mBEGIN::UPDATE-SYSTEM"
sudo apt update;
sudo apt upgrade -y;
sudo apt autoremove;
sudo apt autopurge;
sudo apt autoclean;
echo -e " \n\e[94;1mASTEG-SCRIPTS - STEP 01 | \e[0mEND::UPDATE-SYSTEM"
#--- CONFIGURE-TIMEZONE ---#
echo -e " \n\e[94;1mASTEG-SCRIPTS - STEP 02 | \e[0mBEGIN::CONFIGURATION-TIMEZONES"
sudo timedatectl set-timezone America/Guatemala
echo -e " \n\e[94;1mASTEG-SCRIPTS - STEP 02 | \e[0mEND::CONFIGURATION-TIMEZONES"
#--- CONFIGURE FIREWALL ---#
echo -e " \n\e[94;1mASTEG-SCRIPTS - STEP 03 | \e[0mBEGIN::CONFIGURATION-FIREWALL"
echo -e " \n\e[92;1mSTEP 03 › INSTALL UFW \e[0m"
sudo apt-get install ufw
echo -e " \n\e[92;1mSTEP 03 › CONFIGURE UFW \e[0m"
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 21
ufw allow 22
ufw allow 2222
ufw allow 80
ufw allow 443
echo -e "\n\e[92;1mSTEP 03 › RESTART UFW \e[0m"
ufw enable
echo -e "\n\e[94;1mASTEG-SCRIPTS - STEP 03 | \e[0mEND::CONFIGURATION-FIREWALL"
#--- COMMAND-LINE-APPLICATIONS
echo -e "\n\e[94;1mASTEG-SCRIPTS - STEP 04 | \e[0mBEGIN::COMMAND-LINE-APPLICATIONS"
echo -e "\n\e[92;1mSTEP 04 › BASIC-COMMAND-LINE-INSTALLERS \e[0m"
sudo apt install wget curl rar unrar zip git vim build-essential			#--- BASIC-COMMAND-LINE-INSTALLERS
echo -e "\n\e[92;1mSTEP 04 › BASIC-COMMAND-LINE-UTILITIES \e[0m"
sudo apt install screen multitail findutils speedtest-cli exa bat 			#--- COMMAND-LINE-UTILITIES
echo -e "\n\e[92;1mSTEP 04 › BASIC-COMMAND-LINE-HELPERS \e[0m"
sudo apt install powerline fonts-firacode net-tools neofetch python3-pip	#--- COMMAND-LINE-HELPERS
#--- EDIT-CONFIGURATION-FILES
echo -e "\n\e[92;1mSTEP 04 › CONFIGURE ~/.bashrc \e[0m"
sudo sed -i 's|alias la=.*|alias la="exa -la -stype -sname --group-directories-first"\nalias laa="ls -lAhXG --color=always"\nalias cat="batcat"|' ~/.bashrc
echo "#--ENDOFFILE" >> ~/.bashrc
sudo sed -i 's|#--ENDOFFILE.*|if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then\nsource /usr/share/powerline/bindings/bash/powerline.sh\nfi|' ~/.bashrc
echo -e "\n\e[94;1mASTEG-SCRIPTS - STEP 04 | \e[0mEND::COMMAND-LINE-APPLICATIONS"
echo -e "\n\e[94;1mASTEG-SCRIPTS - STEP 05 | \e[0mBEGIN::INSTALL-APACHE"
echo -e "\e[92;1m¿INSTALAR APACHE?\e[0m"
select apacheChoice in "Si" "No"; do
  case $apacheChoice in
    Si )
		echo -e " \n\e[92;1mSTEP 05 › INSTALL-APACHE \e[0m"
		sudo apt-get -y install apache2
		sudo a2enmod rewrite
		sudo sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
		sudo systemctl restart apache2
		echo -e " \n\e[92;1mSTEP 05 › APACHE-INSTALLED \e[0m"
		break;;
    No ) break;;
  esac
done
echo -e "\e[92;1m¿INSTALAR CERTBOT?\e[0m"
select certbotChoice in "Si" "No"; do
  case $certbotChoice in
    Si )
		echo -e " \n\e[92;1mSTEP 05.ADDITIONAL › INSTALL-CERTBOT-SNAP \e[0m"
		sudo snap install core; sudo snap refresh core
		sudo snap install --classic certbot
		sudo ln -s /snap/bin/certbot /usr/bin/certbot
		sudo certbot --apache
		echo -e " \n\e[92;1mSTEP 05.ADDITIONAL › CERTBOT-SNAP-INSTALLED \e[0m"
		break;;
    No ) break;;
  esac
done
echo -e "\n\e[94;1mASTEG-SCRIPTS - STEP 05 | \e[0mEND::INSTALL-APACHE"
echo -e "\n\e[94;1mASTEG-SCRIPTS - STEP 06 | \e[0mBEGIN::INSTALL-MYSQL"
echo -e "\e[92;1m¿INSTALAR MYSQL?\e[0m"
select mysqlChoice in "Si" "No"; do
  case $mysqlChoice in
    Si )
		echo -e " \n\e[92;1mSTEP 06 › INSTALL-MYSQL \e[0m"
		sudo debconf-set-selections <<<"mysql-server mysql-server/root_password password 0000"
		sudo debconf-set-selections <<<"mysql-server mysql-server/root_password_again password 0000"
		sudo apt-get -y install mysql-server
		echo -e " \n\e[92;1mSTEP 06 › CREATE-DEVELOPMENT-DATABASE \e[0m"
		mysql -uroot -p0000 -e "CREATE DATABASE FRAMEWORK_DATABASE CHARACTER SET UTF8 COLLATE utf8_bin"
		mysql -uroot -p0000 -e "CREATE USER 'FRAMEWORK_USER' IDENTIFIED BY '0000'"
		mysql -uroot -p0000 -e "GRANT ALL PRIVILEGES ON *.* TO 'FRAMEWORK_USER'@'%' WITH GRANT OPTION"
#		mysql -uroot -p0000 -e "USE mysql"
#		mysql -uroot -p0000 -e "UPDATE mysql.user SET plugin='mysql_native_password' WHERE User='root'"
		mysql -uroot -p0000 -e "FLUSH PRIVILEGES"
		echo -e " \n\e[92;1mSTEP 06 › MYSQL INSTALLED \e[0m"
		break;;
    No ) break;;
  esac
done
echo -e "\n\e[94;1mASTEG-SCRIPTS - STEP 06 | \e[0mEND::INSTALL-MYSQL"
echo -e "\n\e[94;1mASTEG-SCRIPTS - STEP 07 | \e[0mBEGIN::INSTALL-PHP"
echo -e "\e[92;1m¿INSTALAR PHP 8.1?\e[0m"
select phpChoice in "Si" "No"; do
  case $phpChoice in
    Si )
		echo -e " \n\e[92;1mSTEP 07 › INSTALL-PHP \e[0m"
		sudo apt install -y php libapache2-mod-php php-common php-curl php-xml php-gd php-imagick php-imap php-intl php-json php-oauth php-mysql php-soap php-cli php-zip php-mbstring
		echo -e " \n\e[92;1mSTEP 07 › CONFIGURE-SERVER \e[0m"
		sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_WARNING \& ~E_DEPRECATED/" /etc/php/8.1/apache2/php.ini
		sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/8.1/apache2/php.ini
		sudo sed -i "s|;extension=mysqli|extension=mysqli|" /etc/php/8.1/apache2/php.ini
		sudo sed -i "s|;date.timezone =|date.timezone = America\/Guatemala|" /etc/php/8.1/apache2/php.ini
		sudo sed -i "s|DirectoryIndex .*|DirectoryIndex index.html index.php|" /etc/apache2/mods-enabled/dir.conf
		sudo systemctl restart apache2
		echo -e " \n\e[92;1mSTEP 07 › PHP INSTALLED \e[0m"
		break;;
    No ) break;;
  esac
done
echo -e "\n\e[94;1mASTEG-SCRIPTS - STEP 07 | \e[0mEND::INSTALL-PHP"
echo -e "\n\e[94;1mASTEG-SCRIPTS - STEP 08 | \e[0mBEGIN::INSTALL-NVM"
echo -e "\e[92;1m¿INSTALAR NVM?\e[0m"
select nvmChoice in "Si" "No"; do
  case $nvmChoice in
    Si )
		echo -e " \n\e[92;1mSTEP 08 › INSTALL-NVM \e[0m"
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
		echo -e " \n\e[92;1mSTEP 08 › CONFIGURE-SYSTEM \e[0m"
		export NVM_DIR="$HOME/.nvm"
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
		[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
		echo -e " \n\e[92;1mSTEP 08 › INSTALL-NODE \e[0m"
		source ~/.bashrc;
		nvm install node;
		echo -e " \n\e[92;1mSTEP 08 › NODE INSTALLED \e[0m"
		break;;
    No ) break;;
  esac
done
echo -e "\n\e[94;1mASTEG-SCRIPTS - STEP 08 | \e[0mEND::INSTALL-NVM"
echo -e "\n\e[94;1m--- ASTEG-SCRIPTS | \e[0mINITIALIZATION-COMPLETED ---"
