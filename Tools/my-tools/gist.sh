#!/opt/local/bin/bash

gist --login
gist "$@" --private | tee /dev/tty | pbcopy