#!/bin/bash
#/2020/10/6
#MSF-login

#Network detection
echo -e "\033[41m(1)Network detection!\033[0m"
#NET="www.baidu.com"
#ping  $NET -c 1
echo -e '\033[32m---------------------------------------\033[0m'

#PATH
File=/root/strap.sh
Sct=systemctl
IN=pacman
Sc=speedtest-cli
GT=greatscottgadgets
LB=libbtbb
UT=ubertooth
bd=build
vvfs=vmware-vmblock-fuse.service
vs=vmtoolsd.server

function network()
{
     local timeout=5
     local target=www.baidu.com
     local ret_code=`curl -I -s --connect-timeout ${timeout} ${target} -w %{http_code} | tail -n1`
echo $ret_code
if [ "$ret_code" = "200" ]; then
       return 0
    else
      return 1
    fi
    return 1
  }

network
  if  [ $? -eq 0 ]; then
      echo "NET_WORKING IS OK !!!!"
    else
     echo "NET_WORKING ERROR!!!!"

#Networing String!
     echo -e '\033[32m----------------------------------------\033[0m'
     read -p " Your network is wrong,whether to set the startup network card:Y or N" pluase
if [ "$pluase" = "Y" -o "$pluase" = "y" ]; then
echo -e "\033[36mView network interface and filter!\033[0m"
Interface=` ip link  | grep ens | sed 's/:/ /g' | awk '{print $2}'`
echo $Interface
echo -e "\033[36mStart the ens33 network interface!\033[0m"
ip link set  $Interface up
echo -e "\033[36mAfter the interface is started,start systemctl!\033[0m"
systemctl enable dhcpcd

#Reboot
echo -e  "\033[36m*****************Reboot*******************\033[0m"
sleep 5s
reboot
else
  echo "Input error,stop!"
  exit
fi
fi
echo -e "\033[34m-------------------Clear!!!!--------------------\033[0m"
sleep 3s
clear

#Installing KEY
echo -e '\033[32m----------------------------------------\033[0m'
echo -e "\033[41m(2)Installing on top of Archlinux!\033[0m"
#Define file
if [ ! -f $File ];then
  echo "The file does not  exists in the directory!"
  curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
sudo ./strap.sh
$IN -Syu
else
  echo "File exists and directory!"
fi
echo -e '\033[32m---------------------------------------\033[0m'

#Install Package
echo -e "\033[41m(3)Install basic packages!\033[0m"
$IN -S open-vm-tools xf86-video-vmware mate-terminal  usbutils neofetch htop mate-terminal
#Netctl was officially replaced with wifi-radar. No installation required
$Sct start $vvfc
$Sct start $vs
$Sct enable $vvfc
$Sct enable $vs
echo -e '\033[32m---------------------------------------\033[0m'
echo -e "\033[41m(4)Optimize related configuration!\033[0m"
$IN -S pulseaudio
pulseaudio -D
echo "##############Install Chinese language#############"
$IN -S wqy-zenhei ttf-fireflysung
locale-gen && locale && locale -a

#about wifi_menu error
#Test network interface
echo -e '\033[32m---------------------------------------\033[0m'
echo -e "\033[41m(5)Wifi_menu error!\033[0m"
echo -e "\033[45m----------------Insert the networkcard!!!-------------------\033[0m"
Interface2=`ifconfig | grep wls35u1 | sed 's/:/ /g' | awk '{print $1}'`
echo $Interface2
if [ "$Interface2" == "wls35u1" ];then
  echo -e "\033[31mNetwork card detected,please wait.....\033[0m"
else
  echo -e "\033[31mNo network card exists!\033[0m"
fi
sleep 3s

#Setting and starting the network card
echo -e "\033[36m*********************WIFI-MENU...************************\033[0m"
sleep 3s
wifi-menu
if [ $? -eq 0 ]; then
  echo "wifi_menu error!"
  ip link set wls35u1 down
  netctl start wls35u1-ssid
else
  echo "wifi_menu ok!"
fi

#Network speed test
echo -e '\033[32m---------------------------------------\033[0m'
echo -e "\033[41m(6)Network speed test!\033[0m"
read -p "Are you sure you want to install this tool?Y or N:" pluase
if [ "$pluase" = "Y" -o "$pluase" = "y" ];then
#install sepedtest_cli
cd /tmp
git clone https://github.com/sivel/$Sc.git
cd /tmp/$Sc
python setup.py install
echo "Install OK!"
echo "***********************GO!..5s******************************"
sleep 5s
clear
echo "Automatically select the nearest server!"
$Sc
echo $Sc"speedtest-cli --list | more ## From near to far!"
echo $Sc"speedtest-cli --serverNumber ## Test the specified server!"

#rm -rf
echo "**********************Clean package or DIR********************"
rm -rf /tmp/$Sc
ls -l
echo -e '\033[32m---------------------------------------\033[0m'
else
  echo "------->Move on to the next step----->"
fi
sleep 3s

#Ubertooth install && compile
echo -e "\033[41m(7)------------Install Ubertooth!-------------\033[0m"
sleep 3s
ubertooth-specan-ui
if [ $? -eq 0 ];then
  echo "The software program starts normally!"
else
  echo "The software program cannot start normally!"
echo "***********************Start install libbtbb****************************"
cd /opt
git clone https://github.com/$GT/$LB.git
cd $LB
mkdir $bd && cd $bd
cmake .. && make && sudo make install
sleep 5s
echo "***********************Start install ubertooth***************************"
cd /root/Downloads
git clone https://github.com/$GT/$UT.git
cd $UT/host
mkdir $bd &&  cd $bd
cmake .. && make && sudo make install
fi
echo "----------OVER!---------"
