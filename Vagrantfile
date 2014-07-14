# Deploy nginx server in Vagrant VM running Ubuntu LTS
# Run higher 1GB memory allocation for server dev, bump to 4-8 once complete
# 
# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|

  	config.vm.network "forwarded_port", guest: 8080, host: 8080,
    	auto_correct: true
	
	config.vm.provider "virtualbox" do |v|	
		v.customize ["modifyvm", :id, "--memory", 1024]
	end
	config.vm.define :radio do |deploy|
		deploy.vm.box = "centos-65-x64-virtualbox-nocm.box"
		deploy.vm.hostname = "radio.server.dev"
		deploy.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-nocm.box"
		deploy.vm.synced_folder "modules", "/etc/puppet/modules"
		deploy.vm.synced_folder "manifests", "/etc/puppet/manifests"
		deploy.vm.network :private_network, ip: "10.1.100.100"
		deploy.vm.provision :shell, :path => "install_puppet.sh"
		#deploy.vm.provision :shell, :path => "pe_mirror.sh"
		deploy.vm.provision :puppet, :module_path => "modules", :manifests_path => "manifests", :manifest_file => "deploy_radio.pp"
	end
end

