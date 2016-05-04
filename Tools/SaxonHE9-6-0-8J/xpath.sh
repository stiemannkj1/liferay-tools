#!/opt/local/bin/bash

output=$(java -classpath '/Users/kylestiemann/Tools/SaxonHE9-6-0-8J/saxon9he.jar' \
net.sf.saxon.Query '!method=text' -s:"$2" -qs:"concat(string-join($1, '&#xA;'), '&#xA;')")

if [[ $output = *[![:blank:]]* ]]; then
	echo "$output"
	exit 0
else
	(>&2 echo 'No results were returned.')
	(>&2 echo 'Make sure that you have the correct namespace for your elements or use "*:" to select all namespaces.')
	exit 1
fi