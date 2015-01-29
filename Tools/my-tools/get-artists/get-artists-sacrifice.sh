#!/bin/sh

URL_PART1="http://www.pandora.com/content/station_track_thumbs?stationId=344940308512544892&page=false&posSortAsc=true&posFeedbackStartIndex="
URL_PART2="&posSortBy=artist"

i=0
curl -s "$URL_PART1$i$URL_PART2" | grep h3\>.*\<\/h3 | perl -n -p -i -e "s/\<h3\>\<a href=\".*?\"\>/Title: /" |     perl -n -p -i -e "s/\<\/a\> by \<a href=\".*?\"\>/ | Artist: /" | perl -n -p -i -e "s/\<\/a\>\<\/h3\>//"

i=5
curl -s "$URL_PART1$i$URL_PART2" | grep h3\>.*\<\/h3 | perl -n -p -i -e "s/\<h3\>\<a href=\".*?\"\>/Title: /" |     perl -n -p -i -e "s/\<\/a\> by \<a href=\".*?\"\>/ | Artist: /" | perl -n -p -i -e "s/\<\/a\>\<\/h3\>//"

for ((i=10; i<=310; i=$((i+10)))) 
do
	curl -s "$URL_PART1$i$URL_PART2" | grep h3\>.*\<\/h3 | perl -n -p -i -e "s/\<h3\>\<a href=\".*?\"\>/Title: /" | perl -n -p -i -e "s/\<\/a\> by \<a href=\".*?\"\>/ | Artist: /" | perl -n -p -i -e "s/\<\/a\>\<\/h3\>//"
done
