#!/opt/local/bin/bash


git commit -a --amend --no-edit
git push -f origin $(git-current-branch.sh)
