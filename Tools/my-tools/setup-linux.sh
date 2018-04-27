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
setxkbmap -layout us -option 'ctrl:nocaps'
(crontab -l ; echo '@reboot /home/kylestiemann/Tools/my-tools/onboot.sh') 2>&1 | \
    grep -v "no crontab" | sort -u | crontab -

# Linux Touchpad Settings
synclient RightButtonAreaTop=0
grep -q 'RightButtonAreaTop=0' ~/.profile ||
    echo 'synclient RightButtonAreaTop=0' >> ~/.profile
synclient RightButtonAreaLeft=0
grep -q 'RightButtonAreaLeft=0' ~/.profile ||
    echo 'synclient RightButtonAreaLeft=0' >> ~/.profile
synclient PalmDetect=1
grep -q 'PalmDetect=1' ~/.profile ||
    echo 'synclient PalmDetect=1' >> ~/.profile
synclient MaxTapTime=0
grep -q 'MaxTapTime=0' ~/.profile ||
    echo 'synclient MaxTapTime=0' >> ~/.profile

# Linux Screen Resolution Settings
xrandr -s '1920x1080'

ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` &> /dev/null || {
    echo 'Please connect to the internet before continuing.'
    exit 1
}

sudo apt update
sudo apt upgrade
sudo apt install \
    chromium-browser \
    shutter \
    ant \
    xclip \
    meld \
    git \
    subversion \
    pandoc \
    ddclient \
    gnome-keyring \
    libgnome-keyring-dev \
    libnotify-bin \
    parallel \
    shutter \
    realpath \
    libxml2-utils

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
    firefox 'https://www.google.com/chrome/browser/desktop/index.html' &
    echo 'Please install google-chrome.'
}

