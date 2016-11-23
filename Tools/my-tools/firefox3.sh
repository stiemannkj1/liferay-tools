#!/opt/local/bin/bash

disable_flash() {
	sudo mv /Library/Internet\ Plug-Ins/Flash\ Player.plugin /Library/Internet\ Plug-Ins/Disabled\ Plug-Ins/ &&
	sudo mv /Library/Internet\ Plug-Ins/flashplayer.xpt /Library/Internet\ Plug-Ins/Disabled\ Plug-Ins/
}

trap disable_flash INT

export JAVA_HOME="$(/usr/libexec/java_home -v 1.6)" &&
sudo mv /Library/Internet\ Plug-Ins/Disabled\ Plug-Ins/Flash\ Player.plugin /Library/Internet\ Plug-Ins/ &&
sudo mv /Library/Internet\ Plug-Ins/Disabled\ Plug-Ins/flashplayer.xpt /Library/Internet\ Plug-Ins/ &&
/Applications/Firefox3.app/Contents/MacOS/firefox-bin -p Firefox3 -no-remote && disable_flash
