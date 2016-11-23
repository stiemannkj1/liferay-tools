#!/opt/local/bin/bash

################################################################################
#
# Copyright (c) 2000-2016 Liferay, Inc. All rights reserved.
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

LIFERAY_FACES_TEST_INTEGRATION="$LIFERAY_FACES/test/integration"

for test in $(gfind "$LIFERAY_FACES_TEST_INTEGRATION/demos" "$LIFERAY_FACES_TEST_INTEGRATION/issues" -maxdepth 2 -regex ".*\(-portlet\|-resources\)" | egrep "$1"); do
	cd $test && mvn test -P integration
done
