#!/opt/local/bin/bash

stop_portal() {
	RUNNING_BOOTSTRAPS="$(jps | grep -o 'Bootstrap' | wc -l | tr -d '[[:space:]]')"
	EXPECTED_RUNNING_BOOTSTRAPS_AFTER_SHUTDOWN="$((RUNNING_BOOTSTRAPS - 1))"
	$TOMCAT/bin/shutdown.sh
	while [ "$(jps | grep -o 'Bootstrap' | wc -l | tr -d '[[:space:]]')" != "$EXPECTED_RUNNING_BOOTSTRAPS_AFTER_SHUTDOWN" ]; do :; done
	exit 0
}

trap 'stop_portal' EXIT

TOMCAT=$(gfind . -maxdepth 1 -name "tomcat-*" | head -1)

if [[ "$@" =~ "reset" ]]; then
	rm -r data/

	if [[ "${PWD##*/}" == *"6.2"* ]]; then
		TOMCAT_WEBAPPS=$TOMCAT/webapps;
		gfind $TOMCAT_WEBAPPS -maxdepth 1 ! -regex "\($TOMCAT_WEBAPPS\|$TOMCAT_WEBAPPS/ROOT\|$TOMCAT_WEBAPPS/marketplace-portlet\|$TOMCAT_WEBAPPS/notifications-portlet\|$TOMCAT_WEBAPPS/resources-importer-web\|$TOMCAT_WEBAPPS/tunnel-web\)" -exec rm -r {} \;
	else
		:
#		OSGI_WAR=osgi/war
#		gfind $OSGI_WAR -maxdepth 1 ! -regex "\($OSGI_WAR\|$OSGI_WAR/user-.*-theme.war\)" -exec rm -r {} \;
#		OSGI_MODULES=osgi/modules
#		gfind $OSGI_MODULES -maxdepth 1 -regex "$OSGI_MODULES/com[.]liferay[.]faces.*" -exec rm -r {} \;
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
	export JAVA_OPTS="$JAVA_OPTS -javaagent:/Users/kylestiemann/.jrebel/jrebel.jar"
fi

# liferay-alert.sh starts an infinite loop watching the portal logs for deploys, so this script must be exited with ^C.
# When the script is killed, stop_portal is executed.
$TOMCAT/bin/catalina.sh $DEBUG start && liferay-alert.sh
