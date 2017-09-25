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

echo "Building..."
if [ $# -eq 0 ]; then
	mvn clean package -P prettyfaces
else
	mvn clean package $@
fi
echo "Done."

WAR_WITH_VERSION=$(fff.sh '[.]war' ./target/)
WAR_WITH_VERSION=${WAR_WITH_VERSION##*/}
WAR_NAME=${WAR_WITH_VERSION//-[0-9][0-9.]*-[A-Za-z0-9][A-Za-z0-9_]*[.]war}
WAR_NAME=${WAR_NAME//[.]war}

TOMCAT_WEBAPPS=/home/kylestiemann/Servers/apache-tomcat-8.0.32/webapps
echo "Removing $TOMCAT_WEBAPPS/$WAR_NAME* ..."
rm -r $TOMCAT_WEBAPPS/$WAR_NAME*
echo "Done."

echo "Copying target/$WAR_WITH_VERSION to $TOMCAT_WEBAPPS/$WAR_NAME.war ..."
cp target/$WAR_WITH_VERSION $TOMCAT_WEBAPPS/$WAR_NAME.war
echo "Done."

growl-complete.sh
