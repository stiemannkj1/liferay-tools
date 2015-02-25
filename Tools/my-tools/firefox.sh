#!/opt/local/bin/bash

URL="$1"
if [ -e "$1" ]; then
	URL="file://$(realpath "$1")"
fi

osascript <<EOD
    tell application "/Applications/FirefoxCurrent/Firefox.app"
        reopen
        activate
    end tell
    delay 0.15
    tell application "System Events"
        keystroke "t" using { command down, shift down }
		keystroke "$URL"
		-- Press "Enter" to go to $URL.
		key code 36
    end tell
EOD


