#!/opt/local/bin/bash

if [ -z "$1" ]; then
	echo "No branches specified for deletion. Exiting."
	exit 0
fi

BRANCHES=$(git branch | ag --case-sensitive -- "$1")
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[ $BRANCHES == *"$CURRENT_BRANCH"* ]]; then
	echo "Cannot delete checked out branch. Exiting."
	exit 1
fi

for branch in $BRANCHES; do
	git push --delete origin "$branch" && git branch -D "$branch"
done
