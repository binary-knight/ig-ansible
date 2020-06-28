#!/usr/bin/bash

yum -y update
yum install -y emacs-nox nano vim tree python3 postgresql java-11-openjdk-devel git
amazon-linux-extras install -y java-openjdk11 nginx1

cd /home/ec2-user
git clone https://github.com/binary-knight/java-image-gallery.git
chown -R ec2-user:ec2-user java-image-gallery
su -c "sh /home/ec2-user/java-image-gallery/gradle-src/install-gradle.sh" ec2-user
su -c "source .bashrc" ec2-user

systemctl stop postfix
systemctl disable postfix
systemctl start nginx
systemctl enable nginx
