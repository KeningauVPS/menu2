#!/bin/bash
#
# Script by LdSeptian
# ==================================================

#configure MySql server
chown -R mysql:mysql /var/lib/mysql/
chmod -R 755 /var/lib/mysql/
apt-get -y install nginx php5 php5-fpm php5-cli php5-mysql php5-mcrypt
rm /etc/nginx/sites-enabled/default && rm /etc/nginx/sites-available/default
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
mv /etc/nginx/conf.d/vps.conf /etc/nginx/conf.d/vps.conf.backup
wget -O /etc/nginx/nginx.conf "http://x-mvst.cf/ld/Debian7/nginx.conf"
wget -O /etc/nginx/conf.d/vps.conf "http://x-mvst.cf/ld/Debian7/vps.conf"
sed -i 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf

# membuat user untuk nginx
useradd -m vps
mkdir -p /home/vps/public_html
rm /home/vps/public_html/index.html
echo -e "<?php phpinfo() ?>" > /home/vps/public_html/info.php
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html
service php5-fpm restart
service nginx restart

#menginstall OCS Panel
cd
echo -e "\e[32;1mMasukan password database kalian..." 
echo -e "\e[33;1mTerus Ketik CREATE DATABASE IF NOT EXISTS OCS_PANEL;EXIT;" 
echo -e "\e[30;1m" 
mysql -u root -p
CREATE DATABASE IF NOT EXISTS OCS_PANEL
EXIT

#install aplikasi git
apt-get install unzip

#install OCS Panel
cd /home/vps/public_html
wget http://x-mvst.cf/ocs/OCSPanel.zip
unzip OCS.zip
chmod 777 /home/vps/public_html/config
chmod 777 /home/vps/public_html/config/config.ini
chmod 777 /home/vps/public_html/config/route.ini

#hapus folder instalation 

#info
clear
echo -e "\e[31;1m===========================================" | tee -a log-install.txt
echo -e "\e[31;1m"  | tee -a log-install.txt
echo -e "\e[32;1mBuka browser, lalu masukkan tulisan di bawah pada browser anda"  | tee -a log-install.txt
echo -e "\e[32;1mhttp://ip-vps:85"  | tee -a log-install.txt
echo -e "\e[37;1m(ganti ip-vps menjadi IP server milik anda, contoh: http://49.213.17.122:85)"  | tee -a log-install.txt
echo -e "\e[31;1m"  | tee -a log-install.txt
echo -e "\e[31;1mSetting seperti berikut:"  | tee -a log-install.txt
echo -e "\e[31;1mDATABASE"  | tee -a log-install.txt
echo -e "\e[31;1mDatabase Host: localhost"  | tee -a log-install.txt
echo -e "\e[31;1mDatabase Name: OCS_PANEL"  | tee -a log-install.txt
echo -e "\e[31;1mDatabase User: root"  | tee -a log-install.txt
echo -e "\e[31;1mDatabase Pass: Password MySQL yang telah dibuat tadi"  | tee -a log-install.txt
echo -e ""  | tee -a log-install.txt
echo -e "\e[31;1mADMIN LOGIN"  | tee -a log-install.txt
echo -e "\e[31;1mUsername: Isikan dengan username OCS yang anda inginkan"  | tee -a log-install.txt
echo -e "\e[31;1mPassword Baru: Isikan dengan password OCS yang anda inginkan"  | tee -a log-install.txt
echo -e "\e[31;1mMasukkan Ulang Password: Input ulang password"  | tee -a log-install.txt
echo -e "\e[33;1mSelesai intsal hapus folder instalation"  | tee -a log-install.txt
echo -e "\e[31;1mrm -R /home/vps/public_html/installation"  | tee -a log-install.txt
echo -e ""  | tee -a log-install.txt
echo -e "===========================================" | tee -a log-install.txt
echo -e "\e[30;1m" 
cd