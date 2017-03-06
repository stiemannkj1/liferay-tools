#!/bin/bash

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

read -r -d '' findFilesScript << EOF
(function() {
	var filesArray = Application('Finder').selection();
	var files = '';

	for (var i = 0; i < filesArray.length; i++) {
		files += unescape(filesArray[i].url()).replace(/^file:\/\//, '') + '\0';
	}

	return files;
})();
EOF

osascript -l JavaScript -e "$findFilesScript" | perl -pe 's/(\r|\n)+$//'
