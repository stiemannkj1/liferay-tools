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

echo mvn test -P integration -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=phantomjs &&
mvn test -P integration -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=phantomjs &&
echo mvn test -P integration -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=firefox &&
mvn test -P integration -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=firefox &&
echo mvn test -P integration -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=chrome &&
mvn test -P integration -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=chrome &&
echo mvn test -P integration,liferay -Dtest="$1" -Dintegration.browser=phantomjs &&
mvn test -P integration,liferay -Dtest="$1" -Dintegration.browser=phantomjs &&
echo mvn test -P integration,liferay -Dtest="$1" -Dintegration.browser=firefox &&
mvn test -P integration,liferay -Dtest="$1" -Dintegration.browser=firefox &&
echo mvn test -P integration,liferay -Dtest="$1" -Dintegration.browser=chrome &&
mvn test -P integration,liferay -Dtest="$1" -Dintegration.browser=chrome &&
echo mvn test -P integration,pluto -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=phantomjs &&
mvn test -P integration,pluto -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=phantomjs &&
echo mvn test -P integration,pluto -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=firefox &&
mvn test -P integration,pluto -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=firefox &&
echo mvn test -P integration,pluto -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=chrome &&
mvn test -P integration,pluto -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=chrome &&
echo mvn test -P integration,alloy -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=phantomjs &&
mvn test -P integration,alloy -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=phantomjs &&
echo mvn test -P integration,alloy -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=firefox &&
mvn test -P integration,alloy -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=firefox &&
echo mvn test -P integration,alloy -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=chrome &&
mvn test -P integration,alloy -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=chrome &&
echo mvn test -P integration,liferay-alloy -Dtest="$1" -Dintegration.browser=phantomjs &&
mvn test -P integration,liferay-alloy -Dtest="$1" -Dintegration.browser=phantomjs &&
echo mvn test -P integration,liferay-alloy -Dtest="$1" -Dintegration.browser=firefox &&
mvn test -P integration,liferay-alloy -Dtest="$1" -Dintegration.browser=firefox &&
echo mvn test -P integration,liferay-alloy -Dtest="$1" -Dintegration.browser=chrome &&
mvn test -P integration,liferay-alloy -Dtest="$1" -Dintegration.browser=chrome &&
echo mvn test -P integration,pluto-alloy -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=phantomjs &&
mvn test -P integration,pluto-alloy -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=phantomjs &&
echo mvn test -P integration,pluto-alloy -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=firefox &&
mvn test -P integration,pluto-alloy -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=firefox &&
echo mvn test -P integration,pluto-alloy -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=chrome &&
mvn test -P integration,pluto-alloy -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=chrome
