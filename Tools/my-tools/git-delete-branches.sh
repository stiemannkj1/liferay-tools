#!/opt/local/bin/bash

if [ -z "$1" ]; then
	echo "No branches specified for deletion. Exiting."
	exit 0
fi

for branch in $(git branch | grep "$1"); do
	git push --delete origin "$branch" && git branch -D "$branch"
done
