#!/opt/local/bin/bash

date=$(gdate -d"last-$1day" +'%Y-%m-%d 00:00:00')
git rev-list -n 1 --before="$date" $2