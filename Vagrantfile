# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"

  config.vm.box = "virtualbox-ubuntu2004"

  config.vm.network "private_network", ip: "192.168.50.250"

  config.vm.network "forwarded_port", guest: 4000, host: 8000

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.name = "VAGRANT-BOX-2004"
  end

  config.vm.provision "shell", inline: <<-SHELL
   sudo apt-get update -y
  SHELL
end

