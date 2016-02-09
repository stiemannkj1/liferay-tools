#!/opt/local/bin/bash

for arg in "$@"; do
	if [ ! -f "$arg" ] && [[ $arg != *":"* ]]; then
		touch "$arg";
	fi
done

/Applications/NetBeans/NetBeans\ 8.1.app/Contents/MacOS/netbeans --open "$@"
