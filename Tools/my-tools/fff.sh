#!/opt/local/bin/bash

for ARG in "$@"; do
	if [ "$ARG" == '-a' ] || [ "$ARG" == '--all' ]; then
		ALL="true"
	elif [ -z "$SEARCH" ]; then
		SEARCH="$ARG"
	else
		SEARCH_DIR+=("$ARG")
	fi
done

if [ ${#SEARCH_DIR[@]} -eq 0 ]; then
	SEARCH_DIR+=(".")
fi

FIND_COMMAND='gfind "${SEARCH_DIR[@]}"'

if [ -z "$ALL" ]; then
	FIND_COMMAND+=' -not \( -path '"'"'*/.git'"'"' -prune \) -not \( -path '"'"'*/target'"'"' -prune \)'
fi

if [ -n "$1" ]; then
	FIND_COMMAND+=' -regextype posix-extended -regex ".*/?$1[^/]*"'
fi

eval $FIND_COMMAND

# TODO read ignores from gitignore:
# gfind ./ -not \( -path '*/.git' -prune \) $(while read line; do printf " -not ( -path '*/$line' -prune ) "; done < .gitignore)
