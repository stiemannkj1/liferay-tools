#!/bin/bash

git reset HEAD -- "$@"
git checkout HEAD -- "$@"
