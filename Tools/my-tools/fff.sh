#!/opt/local/bin/bash

SEARCH_DIR="$2"

if [ -z "$SEARCH_DIR" ]; then
	SEARCH_DIR="."
fi

if [ -z "$1" ]; then
	gfind "$SEARCH_DIR" -not \( -path '*/.git' -prune \) -not \( -path '*/target' -prune \)
else
	gfind "$SEARCH_DIR" -not \( -path '*/.git' -prune \) -not \( -path '*/target' -prune \) -regextype posix-extended -regex ".*/?$1[^/]*"
fi

# TODO read ignores from gitignore:
# gfind ./ -not \( -path '*/.git' -prune \) $(while read line; do printf " -not ( -path '*/$line' -prune ) "; done < .gitignore)
