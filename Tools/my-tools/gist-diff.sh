#!/opt/local/bin/bash

################################################################################
#
# Copyright (c) 2000-2016 Liferay, Inc. All rights reserved.
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
