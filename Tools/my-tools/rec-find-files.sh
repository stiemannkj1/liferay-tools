#!/opt/local/bin/bash

PATTERN="$1"
PATH="."

if (( $# > 1 )); then
	PATH="$2"
fi

function rec_get_files() {

	starting_dir="."

	if [ -n "$1" ]; then
		starting_dir="${1%/}"
	fi

	files=""

	for file in $starting_dir/*; do

		if [ "$file" != "./" ] && [ "$file" != "$starting_dir/*" ]; then

			if ([ -z "$PATTERN" ] || (echo "${file##*/}" | /usr/bin/grep --silent "$PATTERN")); then
				files="$files$file\n"
			fi

			if [ -d "$file" ]; then

				subfiles="$(rec_get_files "$file")"

				if [ -n "$subfiles" ]; then
					files="$files$subfiles\n"
				fi
			fi
		fi
	done

	if [ -n "$files" ]; then
		printf "$files"
	fi
}

rec_get_files "$PATH"