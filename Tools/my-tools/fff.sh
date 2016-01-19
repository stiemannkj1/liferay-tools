#!/opt/local/bin/bash

for ARG in "$@"; do
	if [ -z "$SEARCH" ]; then
		SEARCH="$ARG"
	else
		SEARCH_DIR+=("$ARG")
	fi
done

if [ ${#SEARCH_DIR[@]} -eq 0 ]; then
	SEARCH_DIR+=(".")
fi

if [ -z "$1" ]; then
	gfind "${SEARCH_DIR[@]}" -not \( -path '*/.git' -prune \) -not \( -path '*/target' -prune \)
else
	gfind "${SEARCH_DIR[@]}" -not \( -path '*/.git' -prune \) -not \( -path '*/target' -prune \) -regextype posix-extended -regex ".*/?$1[^/]*"
fi

# TODO read ignores from gitignore:
# gfind ./ -not \( -path '*/.git' -prune \) $(while read line; do printf " -not ( -path '*/$line' -prune ) "; done < .gitignore)
