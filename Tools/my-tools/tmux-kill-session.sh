#!/opt/local/bin/bash

# Clear old tabs.
> ~/Tools/my-tools/.tmux-saved-tabs.txt

# Select the first window and print it's directory to the file otherwise it will be printed last.
tmux select-window -t 0
echo $PWD >> ~/Tools/my-tools/.tmux-saved-tabs.txt

session="$(tmux display-message -p "#S")"
windows="$(tmux list-windows | wc -l)"

# TODO use tmux-run-command.sh instead of manually doing this.
for ((window=0; window < windows; window++)); do

	# Don't print the first window's directory since we already printed it.
	if ((window > 0)); then
		tmux send-keys -t "$session:$window" "echo \$PWD >> ~/Tools/my-tools/.tmux-saved-tabs.txt; history -d \$(history 1)" Enter
	fi
done

tmux kill-session
