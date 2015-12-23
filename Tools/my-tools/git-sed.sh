#!/opt/local/bin/bash

FILES=$(git grep --files-with-matches --name-only "$1")

if [ -n "$FILES" ]; then
	SEARCH="${1/,/\\,}"
	REPLACE="${2/,/\\,}"
	gsed -i -e "s,$SEARCH,$REPLACE,g" $FILES
	echo "$FILES"
fi