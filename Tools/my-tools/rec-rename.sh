#!/opt/local/bin/bash

files="$(~/Tools/my-tools/rec-find-files.sh "$1" | tail -r)"

SEARCH="${1//,/\\,}"
REPLACE="${2//,/\\,}"

for file in $files; do
	renamed_file="$(echo "$file" | gsed "s,\(.*\)$SEARCH,\1$REPLACE,")"
	mv "$file" "$renamed_file"
	echo "renamed \"$file\" to \"$renamed_file\""
done