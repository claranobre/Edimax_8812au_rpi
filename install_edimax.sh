#!/bin/bash

#Update System:

apt-get update
apt-get upgrade -y
rpi-update

#Install deps:
apt-get install dkms build-essential bc raspberrypi-kernel-headers git -y

#Download and install rpi-source:
wget https://raw.githubusercontent.com/notro/rpi-source/master/rpi-source -O /usr/bin/rpi-source && sudo chmod +x /usr/bin/rpi-source && /usr/bin/rpi-source -q --tag-update
rpi-source --skip-gcc

# Downlaod driver:
git clone https://github.com/abperiasamy/rtl8812AU_8821AU_linux
cd rtl8812AU_8821AU_linux/

# Change arch for ARM
sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g' Makefile
sed -i 's/CONFIG_PLATFORM_ARM_RPI = n/CONFIG_PLATFORM_ARM_RPI = y/g' Makefile

#Install driver:
make
make install

# Startup module
modprobe -a rtl8812au

# No start onboard wireless (optional) / remove '#' from the bottom line
#echo "blacklist brcmfmac" > /etc/modprobe.d/raspi-blacklist.conf 

echo "Reboot system for start new modules !!"
