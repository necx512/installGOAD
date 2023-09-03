#!/bin/bash

# This script was tested on Ubuntu 22.04.3 LTS the 03 september 2023
# At this moment, the version of vagrant is 2.3.7. However this version has an issue:
# https://github.com/hashicorp/vagrant/issues/13076
# https://github.com/hashicorp/vagrant/issues/13211#issuecomment-1601665940
# https://github.com/hashicorp/vagrant/releases/tag/2.3.8.dev%2B000032-f72cda8b
# We then use the version 2.3.8.dev%2B000032-f72cda8b in this script


############################# INSTALL DOCKER ####################################################################################
# The instructions in this script come from https://docs.docker.com/engine/install/ubuntu/
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
############################# ------------- ####################################################################################


# Mount
# Install GOAD
cd
lsblk | grep /media/GOAD
if [[ $? != 0 ]]
then
	sudo mount /dev/sdd2 /media/GOAD
fi


# Clean all
sudo apt purge virtualbox
sudo apt purge vagrant
rm -rf /media/GOAD/*
rm -rf "VirtualBox VMs"
rm -rf .vagrant.d
rm -rf GOAD
rm -f vagrant_2.3.8.dev-1_amd64.deb

# Download all package
git clone https://github.com/Orange-Cyberdefense/GOAD.git
wget https://github.com/hashicorp/vagrant/releases/download/2.3.8.dev%2B000086-5fc64cde/vagrant_2.3.8.dev-1_amd64.deb

# Install
sudo apt install virtualbox
sudo dpkg -i vagrant_2.3.8.dev-1_amd64.deb
vagrant plugin install vagrant-vbguest

# Custom message
echo "==============================="
echo "Now, run virtualbox and go on "Fichier" > "parametres" menu. In Général, change the default folder for the machines to /media/GOAD and close virtualbox"
echo "Press any key when it is OK"
echo "==============================="
read -r

# Configure all
cd GOAD
vagrant up
sudo docker build -t goadansible .
sudo docker run -ti --rm --network host -h goadansible -v $(pwd):/goad -w /goad/ansible goadansible ansible-playbook -i ../ad/sevenkingdoms.local/inventory main.yml
