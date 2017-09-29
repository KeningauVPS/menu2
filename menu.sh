#!/bin/bash
#Menu
JUMLAH="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"

CPU=`egrep 'GHz' /proc/cpuinfo` 
IP=`dig +short myip.opendns.com @resolver1.opendns.com` 
UP=`uptime`
HT=`hostname`

echo -e ""
echo -e "\e[35;1m IP        : \e[32;1m $IP"
echo -e "\e[35;1m Server    : \e[32;1m $HT"
echo -e "\e[35;1m Akun aktif: \e[32;1m $JUMLAH"
echo -e ""
echo -e "\e[37;1m ============================✩✩✩ M E N U ✩✩✩============================="
echo -e "\e[36;1m SSH/VPN :" 
echo -e "\e[31;1m  1. \e[33;1m */ menu             : \e[32;1m[Menampilkan Daftar Perintah]"
echo -e "\e[31;1m  2. \e[33;1m */ user-new         : \e[32;1m[Buat Akun SSH / OpenVPN]"
echo -e "\e[31;1m  3. \e[33;1m */ create-trial     : \e[32;1m[Buat Akun Trial]"
echo -e "\e[31;1m  4. \e[33;1m */ delete-user      : \e[32;1m[Hapus Akun SSH / OpenVPN]"
echo -e "\e[31;1m  5. \e[33;1m */ user-list        : \e[32;1m[Cek Daftar Akun Aktif & Masa Expired]"
echo -e "\e[31;1m  6. \e[33;1m */ user-login       : \e[32;1m[Monitoring Dropbear,OpenSSH,OpenVPN]"
echo -e "\e[31;1m  7. \e[33;1m */ dropmon          : \e[32;1m[Monitoring Dropbear]"
echo -e "\e[31;1m  8. \e[33;1m */ limit-login      : \e[32;1m[Kill Multi Login]"
echo -e "\e[31;1m  9. \e[33;1m */ banner-edit      : \e[32;1m[Edit Banner SSH Login]"
echo -e ""
echo -e "\e[36;1m SERVER SETTING :"
echo -e "\e[31;1m 10. \e[33;1m */ speedtest        : \e[32;1m[Cek Kecepatan VPS]"
echo -e "\e[31;1m 11. \e[33;1m */ info             : \e[32;1m[Menampilkan Informasi Sistem]"
echo -e "\e[31;1m 12. \e[33;1m */ mem-info         : \e[32;1m[Info Script Auto Install]"
echo -e "\e[31;1m 13. \e[33;1m */ resvis           : \e[32;1m[restart semua service]"
echo -e "\e[31;1m 14. \e[33;1m */ restart-webmin   : \e[32;1m[Restart Webmin] Service"
echo -e "\e[31;1m 15. \e[33;1m */ restart-ssh      : \e[32;1m[Restart ssh service]"
echo -e "\e[31;1m 16. \e[33;1m */ restart-dropbear : \e[32;1m[Restart dropbear service]"
echo -e "\e[31;1m 17. \e[33;1m */ restart-squid    : \e[32;1m[Restart squid service]"
echo -e "\e[31;1m 18. \e[33;1m */ restart-openvpn  : \e[32;1m[Restart openvpn service]"
echo -e "\e[31;1m 19. \e[33;1m */ change-hostname  : \e[32;1m[Merubah hostname server]"
echo -e "\e[31;1m 20. \e[33;1m */ change-password  : \e[32;1m[Merubah password server]"
echo -e "\e[31;1m 21. \e[33;1m */ change-dropbear  : \e[32;1m[Merubah dropbear port]"
echo -e "\e[31;1m 22. \e[33;1m */ change-squid3    : \e[32;1m[Merubah squid3 port]"
echo -e "\e[31;1m 23. \e[33;1m */ create-ocs       : \e[32;1m[Aktifkan OCS panel]"
echo -e "\e[31;1m 24. \e[33;1m */ change-sslwebmin : \e[32;1m[Error ssl di webmin ganti ssl=1 ke ssl=0]"
echo -e "\e[31;1m 25. \e[33;1m */ about-team       : \e[32;1m[Info Script Auto Install]"
echo -e "\e[31;1m 26. \e[33;1m */ reboot           : \e[32;1m[Reboot VPS]"
echo -e "\e[31;1m 27. \e[33;1m */ update           : \e[32;1m[Update Script]"
echo -e ""
echo -e "\e[31;1m  0. \e[33;1m */ exit             : \e[32;1m[Keluar Dari Menu]"
echo -e "\e[37;1m =====================✩✩✩ copyleft@har1st™ 2017 ✩✩✩======================"
echo -e "\e[37;1m"

read -p "Masukkan pilihan anda, lalu tekan ENTER:" nomer

if [ "$nomer" = "1" ]
then
    menu
elif [ "$nomer" = "2" ]
then
    user-new
elif [ "$nomer" = "3" ]
then
    create-trial
elif [ "$nomer" = "4" ]
then
    delete-user
elif [ "$nomer" = "5" ]
then
    user-list
elif [ "$nomer" = "6" ]
then
    user-login
elif [ "$nomer" = "7" ]
then
   ./dropmon.sh    
elif [ "$nomer" = "8" ]
then
    limit-login
elif [ "$nomer" = "9" ]
then
    banner-edit
elif [ "$nomer" = "10" ]
then
    speedtest
elif [ "$nomer" = "11" ]
then
    info
elif [ "$nomer" = "12" ]
then
    mem-info
elif [ "$nomer" = "13" ]
then
    resvis
elif [ "$nomer" = "14" ]
then
    /etc/init.d/webmin restart
elif [ "$nomer" = "15" ]
then
    service ssh restart
elif [ "$nomer" = "16" ]
then
    service dropbear restart

elif [ "$nomer" = "17" ]
then
    service squid3 restart
elif [ "$nomer" = "18" ]
then
    service openvpn restart

elif [ "$nomer" = "19" ]
then
    nano /etc/hostname
	hostname
elif [ "$nomer" = "20" ]
then
    passwd
elif [ "$nomer" = "21" ]
then
    nano /etc/default/dropbear
elif [ "$nomer" = "22" ]
then
    nano /etc/squid3/squid.conf
	service squid3 restart
elif [ "$nomer" = "23" ]
then
    create-ocs
elif [ "$nomer" = "24" ]
then
    nano /etc/webmin/miniserv.conf
elif [ "$nomer" = "25" ]
then
    about-team
elif [ "$nomer" = "26" ]
then
    reboot
elif [ "$nomer" = "27" ]
then
    update
elif [ "$nomer" = "0" ]
then
    exit
else 
    menu
fi

echo -e "\e[32;1m"	
