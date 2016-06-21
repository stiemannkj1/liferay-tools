#!/opt/local/bin/bash

tmux list-windows -F '#{pane_current_path}' > ~/Tools/my-tools/.tmux-saved-tabs.txt
tmux kill-session
