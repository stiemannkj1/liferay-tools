#!/opt/local/bin/bash

for branch in $(git branch | grep "$1"); do
	git push --delete origin "$branch" && git branch -D "$branch"
done
