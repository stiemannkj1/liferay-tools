#!/bin/bash

for branch in $(git branch -r | grep 'upstream/' | sed 's|\s*upstream/\s*||g'); do
	git checkout $branch &&
		{ git pull upstream $branch &&
		git push origin $branch &&
		git checkout -; } ||
	git checkout -
done