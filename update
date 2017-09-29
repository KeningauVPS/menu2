#!/bin/bash

# go to root
cd

# download
cd /usr/bin
wget -O menu https://raw.githubusercontent.com/KeningauVPS/menu2/master/menu
wget -O banner-edit https://raw.githubusercontent.com/KeningauVPS/menu2/master/banner-edit.sh
wget -O user-new https://raw.githubusercontent.com/KeningauVPS/menu2/master/user-new.sh
wget -O create-trial https://raw.githubusercontent.com/KeningauVPS/menu2/master/user-trial.sh
wget -O delete-user https://raw.githubusercontent.com/KeningauVPS/menu2/master/user-del.sh
wget -O user-login https://raw.githubusercontent.com/KeningauVPS/menu2/master/user-login.sh
wget -O user-list https://raw.githubusercontent.com/KeningauVPS/menu2/master/user-list.sh
wget -O resvis https://raw.githubusercontent.com/KeningauVPS/menu2/master/resvis.sh
wget -O speedtest https://raw.githubusercontent.com/KeningauVPS/menu2/master/speedtest_cli.py
wget -O info https://raw.githubusercontent.com/KeningauVPS/menu2/master/info.sh
wget -O update https://github.com/KeningauVPS/menu2/edit/master/update
wget -O mem-info https://https://raw.githubusercontent.com/KeningauVPS/menu2/master/mrtg-mem.sh
wget -O about-team https://https://raw.githubusercontent.com/KeningauVPS/menu2/master/about.sh
wget -O limit-login https://raw.githubusercontent.com/KeningauVPS/menu2/master/user-limit.sh
wget -O create-ocs https://raw.githubusercontent.com/KeningauVPS/menu2/master/create-ocs.sh
echo "0 0 * * * root /usr/bin/reboot" > /etc/cron.d/reboot
echo "* * * * * service dropbear restart" > /etc/cron.d/dropbear
chmod +x banner-edit
chmod +x user-new
chmod +x create-trial
chmod +x menu
chmod +x delete-user
chmod +x user-login
chmod +x user-list
chmod +x resvis
chmod +x speedtest
chmod +x info
chmod +x mem-info
chmod +x about-team
chmod +x limit-login
chmod +x create-ocs && bash create-ocs.sh
chmod +x update
