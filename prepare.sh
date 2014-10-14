#!/bin/bash
read -p "Enter your assigned ip-address: " NEW_IP
NOOBS_ROOT=$PWD/NOOBS
NEW_ARCHIVE=$PWD/newArchive
INTERFACES=$(cat <<_EOF_
auto lo

iface lo inet loopback
iface eth0 inet static
address $NEW_IP
netmask 255.255.255.0
network 192.168.0.0
broadcast 192.168.0.255
gateway 192.168.0.1
dns-nameserver 8.8.8.8

allow-hotplug wlan0
iface wlan0 inet manual
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
iface default inet dhcp
_EOF_
)

FLAVOURS=$(cat <<_EOFLAVOURS_
{
  "flavours": [
    {
      "name": "Raspbian",
      "description": "A Debian wheezy port, optimised for the Raspberry Pi",
      "feature_level": 123900
    }
  ]
}
_EOFLAVOURS_)

#if [ "$#" -ne 3 ]; then
#  echo "Usage: bash prepare.sh <ip-address> [<username>] [<gw-address>]"
#  exit 1 
#fi
OS=`uname`
function checkIfInstalled {
  echo "Checking if $1 is available..."
  command -v $1 >/dev/null 2>&1 || { 
    echo >&2 "I require $1 but it's not installed, trying to install...";
    if [[ $OS == "Darwin" ]]; then
#      command -v brew >/dev/null 2>&1 || {echo "OSX but no homebrew, can't install";exit 1;}
      brew install $1
    elif [[ $OS == "Linux" ]]; then
#      command -v apt-get >/dev/null 2>&1 || {echo "Linux but no apt-get, can't install";exit 1;}
      sudo apt-get install $1
    else
      echo "You lack $1 and have no suitable package manager for me to download it, please install $1 and come back!"
    fi  
  }
}

function spinner {
  echo "SPINNING"
}
checkIfInstalled "curl"
checkIfInstalled "xz"
checkIfInstalled "unxz"
checkIfInstalled "unzip"
checkIfInstalled "sed"

echo "Downloading NOOBS..."
curl -C - -L -o NOOBS_latest.zip http://downloads.raspberrypi.org/NOOBS_latest

echo "Unzipping..."
echo "unzip -d $NOOBS_ROOT NOOBS*.zip"
unzip -d $NOOBS_ROOT NOOBS*.zip

echo "Creating tmp dir: $NEW_ARCHIVE..."
mkdir $NEW_ARCHIVE

echo "Removing unnecessary stuff..."
find $NOOBS_ROOT/os/ -maxdepth 1 -type d -not -name 'os' -not -name 'Raspbian' -exec rm -rf {} \;

#if [[ -n $USER_NAME && -n $USER_PASSWORD ]]; then
#  echo "Setting user/pw"
#  sed -i.bak -e 's/pi/'$USER_NAME'/' -e 's/raspberry/'$USER_PASSWORD'/' $NOOBS_ROOT/os/Raspbian/os.json
#fi

echo "Pasting flavours..."
echo "$FLAVOURS" > $NOOBS_ROOT/os/Raspbian/flavours.json

echo "Setting silent install"o
sed -i.bak -e 's/^\(.*\)$/\1 silentinstall/' $NOOBS_ROOT/recovery.cmdline

echo "Patching network to given ip-address: $NEW_IP"
mkdir -p $NEW_ARCHIVE/etc/network
echo "$INTERFACES" >$NEW_ARCHIVE/etc/network/interfaces
#cat $NEW_ARCHIVE/etc/network/interfaces 

echo "Extracting network configuration...(will be silent for at least 45 seconds)"
cd $NEW_ARCHIVE && tar xvf $NOOBS_ROOT/os/Raspbian/root.tar.xz etc/init.d/ssh &
  delay=0.75
  spinstr='|/-\'
  counter=0
  while [[ $(ps a |grep "tar xvf" |grep -v "grep") ]]; do
    temp=${spinstr#?}
    printf " [%c]  " "$spinstr"
    spinstr=$temp${spinstr%"$temp"}
    counter=$((counter + 1))
    sleep $delay
    printf "\b\b\b\b\b\b"
  done

#spinner "tar xvf" 

echo "Turning on ssh daemon.."
for i in 2 3 4 5; do mkdir $NEW_ARCHIVE/etc/rc$i.d && ln -s $NEW_ARCHIVE/etc/init.d/ssh $NEW_ARCHIVE/etc/rc$i.d/S02ssh; done

echo "Extracting root file system will take at least a minute..."
cd $NOOBS_ROOT/os/Raspbian/ && unxz root.tar.xz &
  delay=0.75
  spinstr='|/-\'
  counter=0
  while [[ $(ps a |grep "unxz root.tar.xz" |grep -v "grep") ]]; do
    temp=${spinstr#?}
    printf " [%c]  " "$spinstr"
    spinstr=$temp${spinstr%"$temp"}
    counter=$((counter + 1))
    if [[ $counter == 10 ]]; then
      killall -USR1 unxz;
      counter=0;
    fi
    sleep $delay
    printf "\b\b\b\b\b\b"
  done
#spinner "unxs root.tar.xz" "unxz"

echo "Appending network configuration..."
cd $NEW_ARCHIVE && tar rvf $NOOBS_ROOT/os/Raspbian/root.tar .

echo "Repacking root file system, be patient, this is silent for 15 minutes..."
cd $NOOBS_ROOT/os/Raspbian/ && xz root.tar &
  delay=0.75
  spinstr='|/-\'
  counter=0
  while [[ $(ps a |grep "xz root.tar"|grep -v "grep") ]]; do
    temp=${spinstr#?}
    printf " [%c]  " "$spinstr"
    spinstr=$temp${spinstr%"$temp"}
    counter=$((counter + 1))
    if [[ $counter == 10 ]]; then
      killall -USR1 xz;
      counter=0;
    fi
    sleep $delay
    printf "\b\b\b\b\b\b"
  done

echo "Done, copy files to SD card and reboot you pi"
echo "Don't forget apt-get update && apt-get upgrade before doing anything else"

