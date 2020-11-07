# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/focal64"
	#---- SSH-SETTINGS
	config.ssh.insert_key		= false
	config.ssh.private_key_path = ["~/.ssh/id_rsa", "~/.vagrant.d/insecure_private_key"]
	config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys"
	#---- SSH-SETTINGS
	#---- NETWORK CONFIGURATION
	# config.vm.network 		"forwarded_port",	guest: 80, host: 3000
	config.vm.network		"public_network",	ip: "192.168.0.34",	netmask: "255.255.0.0"
	config.vm.synced_folder "data/html",			"/var/www/html", :mount_options => ["dmode=777", "fmode=777"]
	#---- !NETWORK CONFIGURATION
	#---- CONFIGURE PROVIDER
	config.vm.provider "virtualbox" do |virtualbox|
		virtualbox.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
		virtualbox.customize ["modifyvm", :id, "--uartmode1", "file", File::NULL]
		virtualbox.cpus		= 1
		virtualbox.memory 	= 1024
	end
	#---- VAGRANT TRIGGERS
	config.trigger.before [:halt, :suspend, :reload] do |trigger|
		trigger.warn 		= "Backing up database..."
		trigger.run_remote 	= {inline: "DATE=$(date +'%Y%m%d%H%M'); mysqldump -uroot -hlocalhost -p0000 --add-drop-table --no-create-db FRAMEWORK_DATABASE > /var/www/html/resourceCONFIGURATION/FRAMEWORK_DATABASE.$DATE.automatic.sql"}
		trigger.on_error	= :continue
	end
	#---- !VAGRANT TRIGGERS
	#---- !CONFIGURE PROVIDER
	#---- PROVISION
	config.vm.provision "shell",	path: "scripts/vagrant-script.sh"
	#---- !PROVISION
	#---- RUN INITIALIZATION SCRIPT
	config.vm.provision "shell",	inline: "sudo service mysql restart",	run: "always"
	#---- !RUN INITIALIZATION SCRIPT
end
#--- INSTALLATION NOTES
# Please install the following plugins:
# vagrant plugin install vagrant-triggers
#--- END::INSTALLATION NOTES
