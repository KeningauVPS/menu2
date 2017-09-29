#!/bin/bash
#
# Script Copyright x--about.cf
# Mod by har1st
# ==========================
# 

data=( `ps aux | grep -i dropbear | awk '{print $2}'`);

echo -e "\e[37;1m=[-----------------------]=";
echo -e "\e[34;1m=[Checking Dropbear login]=";
echo -e "\e[37;1m=[-----------------------]=";

for PID in "${data[@]}"
do
	#echo "check $PID";
	NUM=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | wc -l`;
	USER=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $10}'`;
	IP=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $12}'`;
	if [ $NUM -eq 1 ]; then
		echo -e "\e[32;1m$PID - \e[37;1m$USER - \e[36;1m$IP";
	fi
done

echo "";

data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);

echo -e "\e[37;1m=[----------------------]=";
echo -e "\e[34;1m=[Checking OpenSSH login]=";
echo -e "\e[37;1m=[----------------------]=";

for PID in "${data[@]}"
do
        #echo "check $PID";
	NUM=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | wc -l`;
	USER=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $9}'`;
	IP=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $11}'`;
        if [ $NUM -eq 1 ]; then
                echo -e "\e[32;1m$PID - \e[37;1m$USER - \e[36;1m$IP";
        fi
done

echo "";

echo -e "\e[37;1m=[------------------------------------------------]="
echo -e "\e[31;1m Multi Login = Kill "
echo -e "\e[31;1m Cara pakai : Kill nomor PID "
read -p "=[PID]= : " killusr
kill -9 $killusr
echo -e "\e[37;1m=[------------------------------------------------]="

echo "";

echo -e "\e[36;1mMod by har1st";
echo -e "\e[30;1m"
