#!/bin/bash

first=true

while read line; do
	if [ "$first" = true ]; then
		tmux new-session -d -c $line
		first=false
	else
		tmux new-window -c $line
	fi
done < ~/Tools/my-tools/.tmux-saved-tabs.txt

tmux select-window -t 0

tmux attach