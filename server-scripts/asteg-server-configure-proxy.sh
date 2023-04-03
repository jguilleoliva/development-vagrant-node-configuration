#!/bin/bash
echo -e "\n\e[94;1m--- ASTEG-SCRIPTS | \e[0mCONFIGURE-PROXY ---"
echo -e " \n\e[94;1mASTEG-SCRIPTS - STEP 01 | \e[0mBEGIN::INSTALL-MODULES-TO-SYSTEM"
sudo apt install libcap2-bin;
sudo a2enmod proxy;
sudo a2enmod proxy_http;
sudo a2enmod proxy_balancer;
sudo a2enmod lbmethod_byrequests;
sudo a2enmod rewrite;
sudo a2enmod headers;
sudo a2enmod expires;
sudo systemctl restart apache2.service
echo -e " \n\e[94;1mASTEG-SCRIPTS - STEP 01 | \e[0mEND::INSTALLED-MODULES-TO-SYSTEM"
echo -e " \n\e[94;1mASTEG-SCRIPTS - STEP 02 | \e[0mBEGIN::CONFIGURE THIS FILES";
echo " 	1. ADD THIS LINES TO /etc/apache2/sites-enabled/<domain-configuration>.conf and\n";
echo "					     /etc/apache2/sites-enabled/<domain-configuration>.com-le\n\n";
echo "		ProxyRequests Off\n";
echo "		ProxyPreserveHost On\n";
echo "		ProxyVia Full\n";
echo "		<Proxy *>\n";
echo "          Require all granted\n";
echo "			# Order deny,allow\n";
echo "			# Allow from all\n";
echo "		</Proxy>\n";
echo "		ProxyPass /<path-to-api> http://127.0.0.1:3000\n";
echo "		ProxyPassReverse /<path-to-api> http://127.0.0.1:3000\n\n";
echo "		After restart service `sudo systemctl restart apache2.service` \n";

echo -e " \n\e[94;1mASTEG-SCRIPTS - STEP 02 | \e[0mEND::CONFIGURE THIS FILES";
