#!/bin/bash
#Filename: setup-ansible-on-vagrant.sh

# Variables
$HOST="cmlink.ddns.net"
$SSH_REMOTE_USER="dveleztx"
$SSH_LOCAL_USER="vagrant"

# Update repo
sudo apt-get update

# Prepare to setup install for ansible
sudo apt-get install software-properties-common -y
sudo apt install python3-pip -y
sudo pip3 install --upgrade pip

# Install Ansible
sudo pip3 install ansible

# Overwrite ansible.cfg file and hosts file
sudo echo -e "[defaults]\nhost_key_checking = False" > /etc/ansible/ansible.cfg
sudo echo -e "[webservers]\n$HOST ansible_ssh_port=22 ansible_ssh_user=$SSH_REMOTE_USER ansible_ssh_private_key_file=/home/$SSH_LOCAL_USER/.ssh/id_rsa" > /etc/ansible/hosts

# Setup Playbooks Path and Import Scripts
cd /etc/ansible; sudo mkdir playbooks; cd playbooks
sudo git clone https://github.com/dveleztx/ansible-https-nginx-letsencrypt.git && cd ansible-https-nginx-letsencrypt
