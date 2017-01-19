#!/opt/local/bin/bash

################################################################################
#
# Copyright (c) 2000-2017 Liferay, Inc. All rights reserved.
#
# This library is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free
# Software Foundation; either version 2.1 of the License, or (at your option)
# any later version.
#
# This library is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
# details.
#
################################################################################

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
