#!/usr/bin/bash

yum -y update
yum install -y postgresql java-11-openjdk-devel git
amazon-linux-extras install -y java-openjdk11 nginx1

cd /home/ec2-user
git clone https://github.com/binary-knight/java-image-gallery.git
chown -R ec2-user:ec2-user java-image-gallery
su -c "sh /home/ec2-user/java-image-gallery/gradle-src/install-gradle.sh" ec2-user
su -c "source .bashrc" ec2-user

export CONFIG_BUCKET="s3://edu.au.cc.image-gallery-knight-config"
aws s3 cp $(CONFIG_BUCKET)/nginx/nginx.conf /etc/nginx/nginx.conf
aws s3 cp $(CONFIG_BUCKET)/nginx/default.d/image_gallery.conf /etc/nginx/default.d/image_gallery.conf

systemctl stop postfix
systemctl disable postfix
systemctl start nginx
systemctl enable nginx

su ec2-user -l -c 'cd ~/java-image-gallery && ./start' >/var/log/image_gallery.log 2>&1 &
