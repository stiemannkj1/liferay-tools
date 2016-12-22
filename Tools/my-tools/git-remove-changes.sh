#!/opt/local/bin/bash

git reset HEAD -- "$@"
git checkout HEAD -- "$@"
