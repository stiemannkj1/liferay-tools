#!/opt/local/bin/bash

if [ -z "$1" ]; then
	echo "No branches specified for deletion. Exiting."
	exit 0
fi

BRANCHES=$(git branch | perl -ne 'print unless /^[*]/' | perl -pe 's/^[ \t]+//g' | ag --case-sensitive -- "$1")
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [ -n "$(echo $CURRENT_BRANCH | ag --case-sensitive -- "$1")" ]; then
	echo "Warning: Cannot delete the currently checked out branch."
fi

if [ -z "$BRANCHES" ]; then
	echo "No deletable branches found."
	exit 1
fi

for branch in $BRANCHES; do
	git push --delete origin "$branch" && git branch -D "$branch"
done
