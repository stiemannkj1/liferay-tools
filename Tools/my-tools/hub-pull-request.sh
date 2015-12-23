#!/opt/local/bin/bash

export GIT_EDITOR=no-edit.sh
hub pull-request "$@" | tee /dev/tty | ag --nocolor '^http' | pbcopy
export GIT_EDITOR=
