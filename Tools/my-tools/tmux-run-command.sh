#!/opt/local/bin/bash

session="$(tmux display-message -p "#S")"
windows="$(tmux list-windows | wc -l)"

for ((window=0; window < windows; window++)); do
	tmux send-keys -t "$session:$window" "$1" Enter
done
