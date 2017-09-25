#!/bin/bash

setxkbmap -layout us -option 'ctrl:nocaps'
sudo /etc/init.d/ddclient start
