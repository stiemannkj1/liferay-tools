#!/bin/bash

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
    if [ "$ARG" == '-Q' ] || [ "$ARG" == '--literal' ]; then
		AG_LITERAL='--literal'
		PERL_LITERAL='\Q'
	elif [ "$ARG" == '-0' ] || [ "$ARG" == '--multiline' ]; then
		# ag does multiline searches by default
		PERL_MULTILINE='-0'
	elif [ "$ARG" == '-d' ] || [ "$ARG" == '--delete-matching-lines' ]; then
		DELETE_MATCHING_LINES="true"
	elif [ "$ARG" == '-n' ] || [ "$ARG" == '--file-names' ] || [ "$ARG" == '--replace-file-names' ]; then
		REC_REP_FILE_NAMES="true"
	elif [ -z "$SEARCH" ]; then
		SEARCH="$ARG"
	elif [ -z "$REPLACE" ] && [ -z "$DELETE_MATCHING_LINES" ]; then
		REPLACE="$ARG"
	else
		SEARCH_DIR+=("$ARG")
	fi
done

if [ -z "$SEARCH" ]; then
	echo 'Error: No search regex or literal specified. Exiting.'
	exit 1
fi

if [ -n "$DELETE_MATCHING_LINES" ] && [ -n "$REC_REP_FILE_NAMES" ]; then
	echo 'Error: "-d" (or "--delete-matching-lines") option is incompatible with "-n" (or "--file-names") option.'
	echo 'Cannot delete matching lines while searching/replacing filenames. Exiting.'
	exit 1
fi

if [ -n "$DELETE_MATCHING_LINES" ] && [ -n "$PERL_MULTILINE" ]; then
	echo 'Warning: Ignoring multiline option "-0" (or "--multiline").'
	echo 'Cannot use multiline matching while deleting lines.'
fi

if [ ${#SEARCH_DIR[@]} -eq 0 ]; then
	SEARCH_DIR+=(".")
fi

FILES=$(ag --case-sensitive --files-with-matches $AG_LITERAL "$SEARCH" "${SEARCH_DIR[@]}")

if [ -n "$FILES" ]; then
	SEARCH="${SEARCH//,/\\,}"
	if [ -n "$DELETE_MATCHING_LINES" ]; then
		perl -n -i -e "print unless m,$PERL_LITERAL$SEARCH," $FILES
	else
		REPLACE="${REPLACE//,/\\,}"
		perl $PERL_MULTILINE -p -i -e "s,$PERL_LITERAL$SEARCH,$REPLACE,g" $FILES
	fi
	echo "$FILES"
fi

if [ -n "$REC_REP_FILE_NAMES" ]; then

	if [ -n "$AG_LITERAL" ]; then
		echo "Literal file name matching is not supported."
	else
		fff.sh "$SEARCH" "${SEARCH_DIR[@]}" | tac | while read FILE; do
			FILE_NAME="${FILE##*/}"
			FILE_PATH="${FILE%/*}"
			NEW_FILE="$FILE_PATH/${FILE_NAME//$SEARCH/$REPLACE}"
			mv "$FILE" "$NEW_FILE"
			echo "Renamed $FILE to $NEW_FILE"
		done
	fi
fi
