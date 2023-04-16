#!/bin/bash
sudo apt update
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get -y install ansible
ansible --version
sleep 5
sudo apt install python-boto3
sudo apt update
sudo apt install python3-pip
sudo apt install python3-boto3
pip show boto3
