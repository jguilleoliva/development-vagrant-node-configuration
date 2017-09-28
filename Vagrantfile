# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/xenial64"
	#---- SSH-SETTINGS
	config.ssh.insert_key 		= true
	config.ssh.private_key_path = ["~/.ssh/id_rsa", "~/.vagrant.d/insecure_private_key"]
	config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys"
	#---- SSH-SETTINGS
	#---- NETWORK CONFIGURATION
	#config.vm.network       "public_network", 	ip: "192.168.1.180", 	netmask: "255.255.0.0"
	config.vm.network "forwarded_port", guest: 80, host: 3000
	config.vm.synced_folder "data/html", 	      "/var/www/html",	:mount_options => ["dmode=777", "fmode=777"]
	config.vm.synced_folder "data/mysql",	      "/var/lib/mysql",	:mount_options => ["dmode=777", "fmode=777"]
	#---- !NETWORK CONFIGURATION
	#---- CONFIGURE PROVIDER
	config.vm.provider "virtualbox" do |virtualbox|
		virtualbox.memory 	= 512
		virtualbox.cpus		= 1
	end
	#---- !CONFIGURE PROVIDER
	#---- PROVISION
	config.vm.provision "shell", path: "scripts/vagrant-script.sh"
	#---- !PROVISION
end
