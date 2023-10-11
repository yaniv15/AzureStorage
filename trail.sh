#!/bin/bash

# Setting up the NFS server
sudo apt update
sudo apt install -y nfs-kernel-server
sudo mkdir -p /mnt/nfs_share
sudo chown -R nobody:nogroup /mnt/nfs_share/
sudo chmod 777 /mnt/nfs_share/
echo "/mnt/nfs_share *(rw,sync,no_subtree_check,insecure)" | sudo tee -a /etc/exports
sudo exportfs -a
sudo systemctl restart nfs-kernel-server

pushd /home/ubuntu
sudo apt install -y python3-pip
sudo pip install google-cloud-storage==2.10.0
sudo pip install gdown==4.7.1
sudo gdown --no-check-certificate --folder https://drive.google.com/drive/folders/1BrHjzjdTbFtknYb-EbbiMh8tS3tEzzDU?usp=sharing
pushd /home/ubuntu/scripts
sudo chmod +x generate_scripts.py
./generate_scripts.py Chainrider
popd
popd

sudo chown -R nobody:nogroup /mnt/nfs_share/
sudo chmod 777 /mnt/nfs_share/ -R
# Download network config, will need to use a variable for this

# Download the templates and the python script for generating
# requirementsss
# chmod +x generate_scripts.py
# ./generate_scripts.py


# Make sure all the scripts are copied to nfs share folder
# sudo cd /mnt/nfs_share/
# sudo chmod +x scripts/ -R