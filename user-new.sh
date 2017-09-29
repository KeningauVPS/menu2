#!/bin/bash
#Script auto create user SSH

clear
echo -e "\e[37;1m+============================+"
echo -e "\e[36;1m+     Buat Akun SSH/OpenVPN   " 
echo -e "\e[37;1m+============================+"
echo -e "" 
read -p " Username   : " Login
read -p " Password   : " Pass
read -p " Masa Aktif : " masaaktif
echo -e "" 
echo -e "\e[37;1m+============================+"

IP=`dig +short myip.opendns.com @resolver1.opendns.com`
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "\e[35;1m======Info Akun SSH/VPN======"
echo -e "\e[33;1mHost     : \e[35;1m$IP"
echo -e "\e[33;1mUsername : \e[35;1m$Login"
echo -e "\e[33;1mPassword  : \e[35;1m$Pass"
echo -e "\e[33;1mEXPIRED  : \e[35;1m$exp"
echo -e "\e[38;1m======Create by har1st™======"
echo -e "\e[33;1mOpenSSH : \e[35;1m22,143"
echo -e "\e[33;1mDropbear : \e[35;1m80,443"
echo -e "\e[33;1mSquid    : \e[35;1m8080,3128"
#echo -e "\e[33;1mOpenVPN : \e[35;1mhttp://$IP:85/client.ovpn"
echo -e "\e[38;1m============================="
echo -e "\e[36;1m          har1st™_ssh"
echo -e "\e[30;1m"
