#!/opt/local/bin/bash

for arg in "$@"; do
	if [[ "$arg" != "-"* ]]; then
		branch="$arg"
	fi
done

git push origin -n "$@"
echo "https://github.com/stiemannkj1/${PWD##*/}/tree/$branch" | tee /dev/tty | pbcopy