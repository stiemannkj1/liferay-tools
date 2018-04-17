#!/bin/bash

################################################################################
#
# Copyright (c) 2000-2018 Liferay, Inc. All rights reserved.
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

currentBranch="$(git-current-branch.sh)"

if [ "$currentBranch" == "master" ]; then
	echo "Error: cannot backport to the master branch. Exiting."
	exit 1
fi

branchNumber="${currentBranch:0:1}"

(git show-ref --verify --quiet refs/heads/$(($branchNumber+1)).x && \
	git cherry-pick $(($branchNumber+1)).x || git cherry-pick master) && git push upstream $currentBranch
