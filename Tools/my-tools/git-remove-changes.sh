#!/bin/bash

args="."

if [ -n "$@" ]; then
	args="@"
fi

git reset HEAD -- "$args"
git checkout HEAD -- "$args"
