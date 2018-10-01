#!/bin/bash

args="."

if (( $# > 0 )); then
	args="$@"
fi

git reset HEAD -- $args
git checkout HEAD -- $args
