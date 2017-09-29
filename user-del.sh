# Script hapus user SSH

echo -e "\e[37;1m[-------------------------------]"
echo -e "\e[37;1m[ USERNAME"      \e[34;1m EXP DATE       ]"
echo -e "\e[37;1m[-------------------------------]"
echo -e "\e[31;1m"
while read expired
do
        AKUN="$(echo $expired | cut -d: -f1)"
        ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
        exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
        if [[ $ID -ge 1000 ]]; then
        printf "%-17s %2s\n" "$AKUN" "$exp"
        fi
done < /etc/passwd
echo -e "\e[37;1m"
read -p "Nama user yang akan dihapus : " Nama
echo -e "\e[30;1m"
userdel -r $Nama
echo -e "\e[30;1m"
