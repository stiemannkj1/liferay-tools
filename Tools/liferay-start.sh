#!/opt/local/bin/bash

stop_portal() {
	echo
	$TOMCAT/bin/catalina.sh stop
	exit 0
}

trap 'stop_portal' EXIT

TOMCAT=$(gfind . -name "tomcat-*" | head -1)

if [[ "$@" =~ "reset" ]]; then
	rm -r data/
	TOMCAT_WEBAPPS=$TOMCAT/webapps;
	gfind $TOMCAT_WEBAPPS -maxdepth 1 ! -regex "\($TOMCAT_WEBAPPS\|$TOMCAT_WEBAPPS/ROOT\|$TOMCAT_WEBAPPS/marketplace-portlet\|$TOMCAT_WEBAPPS/notifications-portlet\|$TOMCAT_WEBAPPS/resources-importer-web\|$TOMCAT_WEBAPPS/tunnel-web\)" -exec rm -r {} \;

	if [[ "${PWD##*/}" == *"5.2"* ]]; then
		cp ../license/license-portaldevelopment-developer-5.2sp5-liferaycom.xml deploy/
	fi
fi

export JAVA_HOME=$(/usr/libexec/java_home -v 1.6)
export PATH=$JAVA_HOME/bin:$PATH
DEBUG=""

if [[ "$@" =~ "debug" ]]; then
	DEBUG="jpda"
elif [[ "$@" =~ "jrebel" ]]; then
	# jrebel.jar is symlinked to the NetBeans version of jrebel.jar via the following command:
	# ln -s "/Applications/NetBeans/NetBeans 8.0.app/Contents/Resources/NetBeans/java2/jrebel/jrebel.jar" .jrebel/jrebel.jar
	export JAVA_OPTS="$JAVA_OPTS -javaagent:/Users/kylestiemann/.jrebel/jrebel.jar"
fi

# liferay-alert.sh starts an infinite loop watching the portal logs for deploys, so this script must be exited with ^C.
# When the script is killed, stop_portal is executed.
$TOMCAT/bin/catalina.sh $DEBUG start && liferay-alert.sh

