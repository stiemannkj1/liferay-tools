#!/opt/local/bin/bash

if [ -z "$2" ]; then
	CHROME_ARGS="--args --incognito --new-window"
fi

/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome $CHROME_ARGS "$1"
