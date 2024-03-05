# packer-ubuntu-vagrant

## How to use Packer to create Ubuntu 20.04 Vagrant boxes

```
i have windows 11 os, install below tools with versions

D:\PACKER\UBUNTU-PACKER>vagrant --version
Vagrant 2.2.16

D:\PACKER\UBUNTU-PACKER>packer --version
1.7.7

virtual box version: 6.1.22
```

```
goto this folder and do cmd

D:\PACKER\UBUNTU-PACKER

```

```
ls

-rw-r--r-- 1 vijay 197121  192 Mar  4 19:02 README.md
-rw-r--r-- 1 vijay 197121  862 Mar  5 09:55 Vagrantfile
-rw-r--r-- 1 vijay 197121 2836 Mar  5 10:24 build.json
drwxr-xr-x 1 vijay 197121    0 Mar  5 09:00 http/
drwxr-xr-x 1 vijay 197121    0 Mar  5 09:16 keys/
drwxr-xr-x 1 vijay 197121    0 Mar  5 09:07 scripts/
```

```
packer validate build.json
```

```
packer build build.json
```

- here, packer will bring up a virtual machine and installs ubuntu20.04 in it and executes our scripts, required packages, forms vagrant box in outputs folder and exits
- to view the background output of build process, we can view from virtual box gui

![image](https://github.com/vijay2181/packer-ubuntu-vagrant/assets/66196388/4db9333f-29ee-4034-b5e2-160f2fd925d8)

- now virtual machine will be destroyed after installing required packages, during build process we can enter into machine by virtualbox gui
- username: vagrant
- password: vagrant

- now we have vagrant box image in outputs folder -> virtualbox-ubuntu2004.box
- we need to add this box to vagrant

```
vagrant box remove virtualbox-ubuntu2004
vagrant box add --name virtualbox-ubuntu2004 file:///D:/UBUNTU-PACKER/outputs/virtualbox-ubuntu2004.box

pwd
/d/UBUNTU-PACKER
```

- now this box is added to local vagrant, we need to bringup virtual machine by using this vagrant box and Vagrantfile
- below is the vagrant file

  
```
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
    vb.name = "VAGRANT-BOX-8"
  end

  config.vm.provision "shell", inline: <<-SHELL
   sudo apt-get update -y
  SHELL
end
```

```
vagrant up
```

- you will get below output

```
$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'virtualbox-ubuntu2004'...
==> default: Matching MAC address for NAT networking...
==> default: Setting the name of the VM: VAGRANT-BOX-8
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
    default: Adapter 2: hostonly
==> default: Forwarding ports...
    default: 4000 (guest) => 8000 (host) (adapter 1)
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: password
    default:
    default: Inserting generated public key within guest...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
==> default: Configuring and enabling network interfaces...
==> default: Mounting shared folders...
    default: /vagrant => D:/UBUNTU-PACKER
Vagrant was unable to mount VirtualBox shared folders. This is usually
because the filesystem "vboxsf" is not available. This filesystem is
made available via the VirtualBox Guest Additions and kernel module.
Please verify that these guest additions are properly installed in the
guest. This is not a bug in Vagrant and is usually caused by a faulty
Vagrant box. For context, the command attempted was:

mount -t vboxsf -o uid=900,gid=900,_netdev vagrant /vagrant

The error output from the command was:
```

```
vagrant ssh
```

```
$ vagrant ssh
==> default: The machine you're attempting to SSH into is configured to use
==> default: password-based authentication. Vagrant can't script entering the
==> default: password for you. If you're prompted for a password, please enter
==> default: the same password you have configured in the Vagrantfile.
Welcome to Ubuntu 20.04.1 LTS (GNU/Linux 5.4.0-42-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

New release '22.04.3 LTS' available.
Run 'do-release-upgrade' to upgrade to it.

Last login: Tue Mar  5 03:59:03 2024
vagrant@vagrant:~$ 
```
