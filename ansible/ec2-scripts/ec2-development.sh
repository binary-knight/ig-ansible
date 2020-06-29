#!/usr/bin/bash

sudo yum -y update
sudo yum install -y emacs-nox nano vim tree python3 postgresql java-11-openjdk-devel git
sudo amazon-linux-extras install -y java-openjdk11 nginx1
sudo su -c "pip3 install ansible --user" ec2-user

cd /home/ec2-user
git clone https://github.com/binary-knight/java-image-gallery.git
chown -R ec2-user:ec2-user java-image-gallery
sudo su -c "sh /home/ec2-user/java-image-gallery/gradle-src/install-gradle.sh" ec2-user
sudo su -c "source .bashrc" ec2-user

sudo systemctl stop postfix
sudo systemctl disable postfix
sudo systemctl start nginx
sudo systemctl enable nginx
