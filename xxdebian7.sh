#!/bin/bash

# go to root
cd

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# install wget and curl
apt-get update;apt-get -y install wget curl;

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart

# set repo
wget -O /etc/apt/sources.list "http://x-mvst.cf/ld/Debian7/sources.list.debian7"
wget "http://x-mvst.cf/ld/Debian7/dotdeb.gpg"
cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg

# remove unused
apt-get -y --purge remove samba*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove bind9*;

# update
apt-get update; apt-get -y upgrade;

# install webserver
apt-get -y install nginx php5-fpm php5-cli

# install essential package
apt-get -y install bmon iftop htop nmap axel nano iptables traceroute sysv-rc-conf dnsutils bc nethogs openvpn vnstat less screen psmisc apt-file whois ptunnel ngrep mtr git zsh mrtg snmp snmpd snmp-mibs-downloader unzip unrar rsyslog debsums rkhunter
apt-get -y install build-essential

# disable exim
service exim4 stop
sysv-rc-conf exim4 off

# update apt-file
apt-file update

# setting vnstat
vnstat -u -i venet0
service vnstat restart

# install screenfetch
cd
wget https://github.com/KittyKatt/screenFetch/raw/master/screenfetch-dev
mv screenfetch-dev /usr/bin/screenfetch
chmod +x 	
echo "clear" >> .profile
echo "screenfetch" >> .profile
chmod 777 /usr/bin/screenfetch


# install webserver
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "http://x-mvst.cf/ld/Debian7/nginx.conf"
mkdir -p /home/vps/public_html
echo "<pre>Setup by @LdSeptian | x-about</pre>" > /home/vps/public_html/index.html
echo "<?php phpinfo(); ?>" > /home/vps/public_html/info.php
wget -O /etc/nginx/conf.d/vps.conf "http://x-mvst.cf/ld/Debian7/vps.conf"
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
service php5-fpm restart
service nginx restart

# install openvpn
wget -O /etc/openvpn/openvpn.tar "http://x-mvst.cf/ld/Debian7/openvpn-debian.tar"
cd /etc/openvpn/
tar xf openvpn.tar
wget -O /etc/openvpn/1194.conf "http://x-mvst.cf/ld/Debian7/1194.conf"
service openvpn restart
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
wget -O /etc/iptables.up.rules "http://x-mvst.cf/ld/Debian7/iptables"
sed -i '$ i\iptables-restore < /etc/iptables' /etc/rc.local
MYIP=`curl -s ifconfig.me`;
MYIP2="s/xxxxxxxxx/$MYIP/g";
sed -i $MYIP2 /etc/iptables.up.rules;
iptables-restore < /etc/iptables.up.rules
service openvpn restart

# configure openvpn client config
cd /etc/openvpn/
wget -O /etc/openvpn/1194-client.ovpn "http://x-mvst.cf/ld/Debian7/1194-client.conf"
sed -i $MYIP2 /etc/openvpn/1194-client.ovpn;
PASS=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 15 | head -n 1`;
useradd -M -s /bin/false Admin
echo "LdSeptian:$PASS" | chpasswd
echo "LdSeptian" > pass.txt
echo "$PASS" >> pass.txt
tar cf client.tar 1194-client.ovpn pass.txt
cp client.tar /home/vps/public_html/
cd
# install badvpn
wget -O /usr/bin/badvpn-udpgw "http://x-mvst.cf/ld/Debian7/badvpn-udpgw"
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300

# install mrtg
wget -O /etc/snmp/snmpd.conf "http://x-mvst.cf/ld/Debian7/snmpd.conf"
wget -O /root/mrtg-mem.sh "http://x-mvst.cf/ld/Debian7/mrtg-mem.sh"
chmod +x /root/mrtg-mem.sh
cd /etc/snmp/
sed -i 's/TRAPDRUN=no/TRAPDRUN=yes/g' /etc/default/snmpd
service snmpd restart
snmpwalk -v 1 -c public localhost 1.3.6.1.4.1.2021.10.1.3.1
mkdir -p /home/vps/public_html/mrtg
cfgmaker --zero-speed 100000000 --global 'WorkDir: /home/vps/public_html/mrtg' --output /etc/mrtg.cfg public@localhost
curl "http://x-mvst.cf/ld/Debian7/mrtg.conf" >> /etc/mrtg.cfg
sed -i 's/WorkDir: \/var\/www\/mrtg/# WorkDir: \/var\/www\/mrtg/g' /etc/mrtg.cfg
sed -i 's/# Options\[_\]: growright, bits/Options\[_\]: growright/g' /etc/mrtg.cfg
indexmaker --output=/home/vps/public_html/mrtg/index.html /etc/mrtg.cfg
if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then mkdir -p /var/log/mrtg ; env LANG=C /usr/bin/mrtg /etc/mrtg.cfg 2>&1 | tee -a /var/log/mrtg/mrtg.log ; fi
if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then mkdir -p /var/log/mrtg ; env LANG=C /usr/bin/mrtg /etc/mrtg.cfg 2>&1 | tee -a /var/log/mrtg/mrtg.log ; fi
if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then mkdir -p /var/log/mrtg ; env LANG=C /usr/bin/mrtg /etc/mrtg.cfg 2>&1 | tee -a /var/log/mrtg/mrtg.log ; fi
cd

# setting port ssh
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
sed -i 's/Port 22/Port  22/g' /etc/ssh/sshd_config
service ssh restart

# install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 443 -p 80"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
service ssh restart
service dropbear restart

# install vnstat gui
cd /home/vps/public_html/
wget http://www.sqweek.com/sqweek/files/vnstat_php_frontend-1.5.1.tar.gz
tar xf vnstat_php_frontend-1.5.1.tar.gz
rm vnstat_php_frontend-1.5.1.tar.gz
mv vnstat_php_frontend-1.5.1 vnstat
cd vnstat
sed -i 's/eth0/venet0/g' config.php
sed -i "s/\$iface_list = array('venet0', 'sixxs');/\$iface_list = array('venet0');/g" config.php
sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php
sed -i 's/Internal/Internet/g' config.php
sed -i '/SixXS IPv6/d' config.php
cd

# install fail2ban
apt-get -y install fail2ban;service fail2ban restart

# install squid3
apt-get -y install squid3
wget -O /etc/squid3/squid.conf "http://x-mvst.cf/ld/Debian7/squid3.conf"
sed -i $MYIP2 /etc/squid3/squid.conf;
service squid3 restart

# install webmin
cd
wget "http://prdownloads.sourceforge.net/webadmin/webmin_1.670_all.deb"
dpkg --install webmin_1.670_all.deb;
apt-get -y -f install;
rm /root/webmin_1.670_all.deb
service webmin restart
service vnstat restart

# download
cd /usr/bin
wget -O menu "https://github.com/har1st/Debian7/blob/master/menu.sh"
wget -O banner-edit "https://github.com/har1st/Debian7/blob/master/banner-edit.sh"
wget -O user-new "https://github.com/har1st/Debian7/blob/master/user-new.sh"
wget -O create-trial "https://github.com/har1st/Debian7/blob/master/user-trial.sh"
wget -O delete-user "https://github.com/har1st/Debian7/blob/master/user-del.sh"
wget -O user-login "https://github.com/har1st/Debian7/blob/master/user-login.sh"
wget -O user-list "https://github.com/har1st/Debian7/blob/master/user-list.sh"
wget -O resvis "https://github.com/har1st/Debian7/blob/master/resvis.sh"
wget -O speedtest "http://x-mvst.cf/ld/Debian7/speedtest_cli.py"
wget -O info "https://github.com/har1st/Debian7/blob/master/info.sh"
wget -O mem-info "https://github.com/har1st/Debian7/blob/master/mrtg-mem.sh"
wget -O about-team "https://github.com/har1st/Debian7/blob/master/about.sh"
wget -O limit-login "https://github.com/har1st/Debian7/blob/master/user-limit.sh"
wget -O create-ocs "https://github.com/har1st/Debian7/blob/master/create-ocs.sh"
echo "0 0 * * * root /usr/bin/reboot" > /etc/cron.d/reboot
echo "* * * * * service dropbear restart" > /etc/cron.d/dropbear
chmod +x menu
chmod +x banner-edit
chmod +x user-new
chmod +x create-trial
chmod +x delete-user
chmod +x user-login
chmod +x user-list
chmod +x resvis
chmod +x speedtest
chmod +x info
chmod +x mem-info
chmod +x about-team
chmod +x limit-login
chmod +x create-ocs


# finalisasi
chown -R www-data:www-data /home/vps/public_html
service nginx start
service php-fpm start
service vnstat restart
service openvpn restart
service snmpd restart
service ssh restart
service dropbear restart
service fail2ban restart
service squid3 restart
service webmin restart
rm -rf ~/.bash_history && history -c
echo "unset HISTFILE" >> /etc/profile

# info
clear
echo -e "\e[36;1m Autoscript Include: installer by @LdSeptian" | tee log-install.txt
echo -e "\e[36;1m ===========================================" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo -e "\e[32;1m Service"  | tee -a log-install.txt
echo -e "\e[32;1m -------"  | tee -a log-install.txt
echo -e "\e[37;1m OpenSSH  : 22, 143"  | tee -a log-install.txt
echo -e "\e[32;1m Dropbear : 80, 443"  | tee -a log-install.txt
echo -e "\e[32;1m Squid3   : 8080, 3128 (limit to IP SSH)"  | tee -a log-install.txt
echo -e "\e[37;1m OpenVPN  : TCP 1194 (client config : http://$MYIP:81/client.ovpn)"  | tee -a log-install.txt
echo -e "\e[32;1m badvpn   : badvpn-udpgw port 7300"  | tee -a log-install.txt
echo -e "\e[37;1m nginx    : 80"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo -e "\e[37;1m Script"  | tee -a log-install.txt
echo -e "\e[37;1m- -----"  | tee -a log-install.txt
echo -e "\e[35;1m menu          (Menampilkan daftar perintah yang tersedia)"  | tee -a log-install.txt
echo -e "\e[35;1m banner-edit   (Mengganti banner login)"  | tee -a log-install.txt
echo -e "\e[35;1m user-new 	    (Membuat Akun SSH)"  | tee -a log-install.txt
echo -e "\e[35;1m create-trial  (Membuat Akun Trial)"  | tee -a log-install.txt
echo -e "\e[35;1m delete-user   (Menghapus Akun SSH)"  | tee -a log-install.txt
echo -e "\e[38;1m user-login    (Cek User Login)"  | tee -a log-install.txt
echo -e "\e[38;1m user-list     (Cek Member SSH)"  | tee -a log-install.txt
echo -e "\e[38;1m resvis        (Restart Service dropbear, webmin, squid3, openvpn dan ssh)"  | tee -a log-install.txt
echo -e "\e[34;1m reboot        (Reboot VPS)"  | tee -a log-install.txt
echo -e "\e[34;1m speedtest     (Speedtest VPS)"  | tee -a log-install.txt
echo -e "\e[34;1m info          (Menampilkan Informasi Sistem)"  | tee -a log-install.txt
echo -e "\e[34;1m mem-info      (Menampilkan Informasi memory)" | tee -a log-install.txt
echo -e "\e[34;1m limit-login	        (kill multy login)" | tee -a log-install.txt
echo -e "\e[34;1m about-team   (Informasi tentang script auto install)"  | tee -a log-install.txt
echo -e "\e[35;1m Account Default (utk SSH dan VPN)"  | tee -a log-install.txt
echo -e "---------------"  | tee -a log-install.txt
echo -e "\e[35;1m User     : LdSeptian"  | tee -a log-install.txt
echo -e "\e[35;1m Password : $PASS"  | tee -a log-install.txt
echo -e ""  | tee -a log-install.txt
echo -e "\e[35;1m =[Fitur lain]="  | tee -a log-install.txt
echo -e "\e[35;1m =[----------]="  | tee -a log-install.txt
echo -e "\e[36;1m =[Webmin   : http://$MYIP:10000/]="  | tee -a log-install.txt
echo -e "\e[36;1m =[Timezone : Asia/Jakarta (GMT +7)]="  | tee -a log-install.txt
echo -e "\e[36;1m =[IPv6     : [off]]="  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo -e "\e[37;1m =[Original Script by @Ldseptian | x-about]="  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo -e "\e[37;1m =[Log Instalasi --> /root/log-install.txt]="  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo -e "\e[33;1m =[VPS AUTO REBOOT TIAP 12 JAM]="  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo -e "=[===========================================]="  | tee -a log-install.txt
echo -e "\e[31;1m =[Silahkan Reboot VPS anda!]="  | tee -a log-install.txt
echo -e "\e[33;1m =[===========================================]="  | tee -a log-install.txt

