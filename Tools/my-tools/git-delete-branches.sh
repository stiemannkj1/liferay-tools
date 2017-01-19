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

if [ -z "$1" ]; then
	echo "No branches specified for deletion. Exiting."
	exit 0
fi

BRANCHES=$(git branch | perl -ne 'print unless /^[*]/' | perl -pe 's/^[ \t]+//g' | ag --case-sensitive -- "$1")
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [ -n "$(echo $CURRENT_BRANCH | ag --case-sensitive -- "$1")" ]; then
	echo "Warning: Cannot delete the currently checked out branch."
fi

if [ -z "$BRANCHES" ]; then
	echo "No deletable branches found."
	exit 1
fi

for branch in $BRANCHES; do
	git push --delete origin "$branch" && git branch -D "$branch"
done
