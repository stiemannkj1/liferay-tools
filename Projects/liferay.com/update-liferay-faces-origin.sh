#!/bin/bash

for repo in liferay-faces-*; do
	(cd $repo &&
	git diff-index --quiet --cached HEAD -- &&
	{ git fetch upstream &&
	git remote update --prune upstream &&
	./update-origin.sh; } ||
	echo "Failed to update origin for $repo")
done