# TO RUN NODE AS A REVERSE PROXY ON APACHE IN PORT 80
---
## 	0. CONFIGURE TO RUN FROM PORT 80
```bash
sudo apt-get install libcap2-bin
sudo setcap cap_net_bind_service=+ep `readlink -f \`which node\``
```
## 	1. ADD THIS LINES _/etc/apache2/sites-enabled/<domain-configuration>.conf and /etc/apache2/sites-enabled/<domain-configuration>.com-le_
```apacheconf
ProxyRequests Off
ProxyPreserveHost On
ProxyVia Full
<Proxy *>
    Require all granted
	# Order deny,allow
	# Allow from all
</Proxy>
ProxyPass /<path-to-api> http://127.0.0.1:3000/
ProxyPassReverse /<path-to-api> http://127.0.0.1:3000/
```
## 	2. RUN THIS 2 BASH SCRIPTS
```bash
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod proxy_balancer
sudo a2enmod lbmethod_byrequests
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod expires
```
## 	3. RESTART APACHE
```bash
sudo systemctl restart apache2.service
```
_@REF https://blog.containerize.com/2021/05/21/how-to-configure-apache-as-a-reverse-proxy-for-ubuntudebian/_


# RUN NODE IN THE BACKGROUND
---
## 0. INSTALL PM2
```bash
sudo npm install pm2@latest -g
```

## 1. RUN IN PM2
```bash
# (old way) pm2 start "npm start" or "nodemon -L src/index.js"
pm2 start src/index.js --watch (sin nodemon y con reload)
pm2 startup systemd
follow promts to run a command
pm2 save
```

# RECONFIGURE MYSQL
_TO CHANGE PASSWORD, LOAD MYSQL AND RUN THIS COMMAND_
```bash
	ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY '<new-password>'; (mysql 8+)
	ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '<new-password>'; (mysql 5.7)
```

# INSTALL-TERMINAL-APPS

### GPING
```bash
echo "deb [signed-by=/usr/share/keyrings/azlux-archive-keyring.gpg] http://packages.azlux.fr/debian/ stable main" | sudo tee /etc/apt/sources.list.d/azlux.list
sudo wget -O /usr/share/keyrings/azlux-archive-keyring.gpg  https://azlux.fr/repo.gpg
sudo apt update; sudo apt upgrade -y
sudo apt install gping
```
### COMMAND-LINE-CONFIGURATION
```bash
sudo apt install git
cd ~
git init; 
git remote add origin git@github.com:jguilleoliva/asteg-server-configuration.git;
mv .bashrc .bashrc.old;
git pull origin master;
```

### FIX KNOWN-HOSTS HASHING INFORMATION
```bash
sudo vim /etc/ssh/ssh_config
and comment #HashKnownHosts yes
```

### DISABLE IPv6 ON VAGRANT
```bash
sudo vim /etc/default/grub
in vim, change line from to
GRUB_CMDLINE_LINUX=""
GRUB_CMDLINE_LINUX="ipv6.disable=1"
sudo update-grub
sudo shutdown -r now
```

### INSTALL R BASELINE
```bash
sudo apt install -y --no-install-recommends software-properties-common dirmngr
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
sudo apt install -y r-base r-base-core r-recommended r-base-dev
```
After that type R, you will get R environment and install
```R
install.packages("dplyr");
```


### NOTES
    - @REMEMBER to use nodemon -L (legacy) when inside a container environment.
    - @REMEMBER configure mysql or pg database driver at /library-database
    - @REMEMBER to set mysql to `ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';`
