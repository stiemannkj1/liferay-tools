#!/opt/local/bin/bash

################################################################################
#
# Copyright (c) 2000-2016 Liferay, Inc. All rights reserved.
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

disable_flash() {
	sudo mv /Library/Internet\ Plug-Ins/Flash\ Player.plugin /Library/Internet\ Plug-Ins/Disabled\ Plug-Ins/ &&
	sudo mv /Library/Internet\ Plug-Ins/flashplayer.xpt /Library/Internet\ Plug-Ins/Disabled\ Plug-Ins/
}

trap disable_flash INT

export JAVA_HOME="$(/usr/libexec/java_home -v 1.6)" &&
sudo mv /Library/Internet\ Plug-Ins/Disabled\ Plug-Ins/Flash\ Player.plugin /Library/Internet\ Plug-Ins/ &&
sudo mv /Library/Internet\ Plug-Ins/Disabled\ Plug-Ins/flashplayer.xpt /Library/Internet\ Plug-Ins/ &&
/Applications/Firefox3.app/Contents/MacOS/firefox-bin -p Firefox3 -no-remote && disable_flash
