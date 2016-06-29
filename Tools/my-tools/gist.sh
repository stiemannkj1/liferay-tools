#!/opt/local/bin/bash

gist "$@" --private | tee /dev/tty | pbcopy
