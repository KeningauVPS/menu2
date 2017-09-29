#!/bin/bash
#info

nano /etc/banner-ssh
echo "Banner /etc/banner-ssh" >> /etc/ssh/sshd_config
echo "DROPBEAR_BANNER="/etc/banner-ssh"" >> /etc/default/dropbear
service ssh restart && service dropbear restart

echo -e "\e[32;1m Succses" 