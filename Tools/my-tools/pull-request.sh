#!/opt/local/bin/bash

export GIT_EDITOR=~/Tools/my-tools/no-edit.sh
hub pull-request $@
export GIT_EDITOR=
