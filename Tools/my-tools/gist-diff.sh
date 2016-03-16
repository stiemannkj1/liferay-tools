#!/opt/local/bin/bash

if [[ -z "$1" ]] || [[ -z "$2" ]]; then
	echo "Usage: gist-diff.sh [file|url] [file|url]"
fi

FILE1="$1"
if [[ "$1" == http* ]]; then
	FILE1='<(curl -s "$1")'
fi

FILE2="$2"
if [[ "$2" == http* ]]; then
	FILE2='<(curl -s "$2")'
fi

gist.sh <(eval diff $FILE1 $FILE2 -u | gsed "1iLeft:  $1\nRight: $2\n") -f diff.diff
