#!/bin/bash -eux

# Add vagrant user to sudoers.
echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Check if the SSH directory exists, if not, create it
if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
    chmod 700 ~/.ssh
fi

# Change ownership of ~/.ssh directory and its contents to vagrant user
chown -R vagrant:vagrant ~/.ssh

