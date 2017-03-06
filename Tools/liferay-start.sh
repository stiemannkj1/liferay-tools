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

stop_portal() {
	RUNNING_BOOTSTRAPS="$(jps | grep -o 'Bootstrap' | wc -l | tr -d '[[:space:]]')"
	EXPECTED_RUNNING_BOOTSTRAPS_AFTER_SHUTDOWN="$((RUNNING_BOOTSTRAPS - 1))"
	$TOMCAT/bin/shutdown.sh
	while [ "$(jps | grep -o 'Bootstrap' | wc -l | tr -d '[[:space:]]')" != "$EXPECTED_RUNNING_BOOTSTRAPS_AFTER_SHUTDOWN" ]; do :; done
	exit 0
}

trap 'stop_portal' EXIT

TOMCAT=$(find . -maxdepth 1 -name "tomcat-*" | head -1)

if [[ "$@" =~ "reset" ]]; then
	rm -r data/

	if [[ "${PWD##*/}" == *"6.2"* ]]; then
		TOMCAT_WEBAPPS=$TOMCAT/webapps;
		find $TOMCAT_WEBAPPS -maxdepth 1 ! -regex "\($TOMCAT_WEBAPPS\|$TOMCAT_WEBAPPS/ROOT\|$TOMCAT_WEBAPPS/marketplace-portlet\|$TOMCAT_WEBAPPS/notifications-portlet\|$TOMCAT_WEBAPPS/resources-importer-web\|$TOMCAT_WEBAPPS/tunnel-web\)" -exec rm -r {} \;
	else
		:
#		OSGI_WAR=osgi/war
#		find $OSGI_WAR -maxdepth 1 ! -regex "\($OSGI_WAR\|$OSGI_WAR/user-.*-theme.war\)" -exec rm -r {} \;
#		OSGI_MODULES=osgi/modules
#		find $OSGI_MODULES -maxdepth 1 -regex "$OSGI_MODULES/com[.]liferay[.]faces.*" -exec rm -r {} \;
	fi
fi

DEBUG=""

if [[ "$@" =~ "debug" ]]; then
	export JPDA_ADDRESS=8000
	export JPDA_TRANSPORT=dt_socket
	DEBUG="jpda"
elif [[ "$@" =~ "jrebel" ]]; then
	# jrebel.jar is symlinked to the NetBeans version of jrebel.jar via the following command:
	# ln -s "/Applications/NetBeans/NetBeans 8.0.app/Contents/Resources/NetBeans/java2/jrebel/jrebel.jar" .jrebel/jrebel.jar
	export JAVA_OPTS="$JAVA_OPTS -javaagent:/home/kylestiemann/.jrebel/jrebel.jar"
fi

# liferay-alert.sh starts an infinite loop watching the portal logs for deploys, so this script must be exited with ^C.
# When the script is killed, stop_portal is executed.
$TOMCAT/bin/catalina.sh $DEBUG start && liferay-alert.sh
