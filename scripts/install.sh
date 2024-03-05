#!/bin/bash

sleep 30

# Add the public key to authorized_keys if not already there
if ! grep -qF "$(cat ~/.ssh/id_rsa.pub)" ~/.ssh/authorized_keys; then
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
fi

# Display the public key
echo "Your public key is:"
cat ~/.ssh/id_rsa.pub


sudo apt update -y
sudo apt install git -y
sudo apt install net-tools -y

sudo echo "Hi This is Vijay" > /home/vagrant/vijay.txt