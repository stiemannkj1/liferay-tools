#!/bin/bash

################################################################################
#
# Copyright (c) 2000-2017 Liferay, Inc. All rights reserved.
#
# This library is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free
# Software Foundation; either version 2.1 of the License, or (at your option)
# any later version.
#
# This library is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
# details.
#
################################################################################

# Linux Keyboard Settings
setxkbmap -layout us -option 'ctrl:nocaps,altwin:swap_lalt_lwin'
(crontab -l ; echo '@reboot /home/kylestiemann/Tools/my-tools/onboot.sh') 2>&1 | \
    grep -v "no crontab" | sort -u | crontab -

echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
grep -q  'options hid_apple fnmode=2' /etc/modprobe.d/hid_apple.conf 2> /dev/null || {
    echo 'options hid_apple fnmode=2' | sudo tee -a /etc/modprobe.d/hid_apple.conf &&
    sudo update-initramfs -u -k all
}

# Linux Touchpad Settings
synclient PalmDetect=1
grep -q 'PalmDetect=1' ~/.profile ||
    echo synclient PalmDetect=1 >> ~/.profile

# Linux Screen Resolution Settings
xrandr -s '1680x1050'

ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` &> /dev/null || {
    sudo apt install bcmwl-kernel-source
    echo 'Please connect to the internet before continuing.'
    exit 1
}

sudo apt update
sudo apt upgrade
sudo apt install \
    chromium-browser \
    silversearcher-ag \
    maven \
    ant \
    tmux \
    xsel \
    git \
    pandoc \
    ddclient \
    libgnome-keyring-dev

cd /usr/share/doc/git/contrib/credential/gnome-keyring
sudo make
git config --global credential.helper \
    /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring
cd -

if [ ! -L /etc/ddclient.conf ]; then
    sudo rm /etc/ddclient.conf
    sudo ln ~/Tools/my-tools/ddclient.conf -s /etc/ddclient.conf
    sudo sed -i \
        -e 's/(run_dhclient)="[^"]*"/$1="false"/' \
        -e 's/(run_ipup)="[^"]*"/$1="false"/' \
        -e 's/(run_daemon)="[^"]*"/$1="true"/' \
        -e 's/(daemon_interval)="[^"]*"/$1="300"/' \
        /etc/default/ddclient
    sudo /etc/init.d/ddclient start
fi

hash google-chrome 2> /dev/null || {
    firefox 'https://www.google.com/chrome/browser/desktop/index.html'
    echo 'Please install google-chrome.'
}

