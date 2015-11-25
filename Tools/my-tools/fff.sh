#!/opt/local/bin/bash

if [ -z "$1" ]; then
	echo "An argument is required."
fi

SEARCH_DIR="$2"

if [ -z "SEARCH_DIR" ]; then
	SEARCH_DIR="./"
fi

/opt/local/bin/gfind $SEARCH_DIR -regextype posix-extended -regex ".*/?$1[^/]*"
