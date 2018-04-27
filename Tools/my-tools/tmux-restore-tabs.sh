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

first=true
tmux new-session -d

while read line; do
	tmux new-window -c $line

	if [ "$first" = true ]; then
		tmux kill-window -t 0
		tmux move-window -s 1 -t 0
		first=false
	fi
done < ~/Tools/my-tools/.tmux-saved-tabs.txt

tmux select-window -t 0

tmux attach
