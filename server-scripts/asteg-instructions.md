## A. TO RUN NODE AS A REVERSE PROXY ON APACHE IN PORT 80
##
## 	0. CONFIGURE TO RUN FROM PORT 80
## 		sudo apt-get install libcap2-bin
## 		sudo setcap cap_net_bind_service=+ep `readlink -f \`which node\``
##
## 	1. ADD THIS LINES TO /etc/apache2/sites-enabled/<domain-configuration>.conf and
##					     /etc/apache2/sites-enabled/<domain-configuration>.com-le
##
##		ProxyRequests Off
##		ProxyPreserveHost On
##		ProxyVia Full
##		<Proxy *>
##          Require all granted
##			# Order deny,allow
##			# Allow from all
##		</Proxy>
##		ProxyPass /<path-to-api> http://127.0.0.1:3000
##		ProxyPassReverse /<path-to-api> http://127.0.0.1:3000
##
## 	2. RUN THIS 2 BASH SCRIPTS
##		sudo a2enmod proxy
##		sudo a2enmod proxy_http
##		sudo a2enmod proxy_balancer
##		sudo a2enmod lbmethod_byrequests
##		sudo a2enmod rewrite
##		sudo a2enmod headers
##		sudo a2enmod expires
##
## 	3. RESTART APACHE
## 		sudo systemctl restart apache2.service
##
## @REF https://blog.containerize.com/2021/05/21/how-to-configure-apache-as-a-reverse-proxy-for-ubuntudebian/
##

##
## B. INSTALL NODE (IF REQUIRED)
## 0. INSTALL NODE
##      curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - &&\
##      sudo apt-get install -y nodejs
##
## 1. CONFIGURE NODE MODULES
##      mkdir ~/.npm-global
##      sudo chown $USER /usr/lib/node_modules
##      npm config set prefix '~/.npm-global'
##
## 2. EDIT ~/.bashrc add the following line
##      export PATH=~/.npm-global/bin:$PATH
##
## 3. CONFIGURE BASH
##      source ~/.bashrc
##      npm install -g jshint
##

## C. RUN NODE IN THE BACKGROUND
##
## 0. INSTALL PM2
##		sudo npm install pm2@latest -g
##
## 1. RUN IN PM2
##		(old way) pm2 start "npm start" or "nodemon -L src/index.js"
##      pm2 start src/index.js --watch (sin nodemon y con reload)
## 		pm2 startup systemd
##			follow promts to run a command
##		pm2 save
##
##	@REMEMBER to use nodemon -L (legacy) when inside a container environment.
##  @REMEMBER configure mysql or pg database driver at /library-database
##  @REMEMBER to set mysql to `ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';`
