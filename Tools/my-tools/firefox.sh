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

URL="$1"
if [ -e "$1" ]; then
	URL="file://$(realpath "$1")"
fi

osascript <<EOD
    tell application "/Applications/Firefox.app"
        reopen
        activate
    end tell
    delay 0.15
    tell application "System Events"
        keystroke "t" using { command down }
		keystroke "$URL"
		-- Press "Enter" to go to $URL.
		key code 36
    end tell
EOD


