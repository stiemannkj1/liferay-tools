#!/opt/local/bin/bash

################################################################################
#
# Copyright (c) 2000-2017 Liferay, Inc. All rights reserved.
#
# This library is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free
# Software Foundation; either version 2.1 of the License, or (at your option)
# any later version.
#
# This library is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
# details.
#
################################################################################

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
