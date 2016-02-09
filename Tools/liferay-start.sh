#!/opt/local/bin/bash

stop_portal() {
	echo
	$TOMCAT/bin/shutdown.sh
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
	elif [[ "${PWD##*/}" == *"6.0"* ]]; then

		TOMCAT_WORK_CATALINA_LOCALHOST=$TOMCAT/work/Catalina/localhost
		gfind $TOMCAT_WORK_CATALINA_LOCALHOST -maxdepth 1 ! -regex "\($TOMCAT_WORK_CATALINA_LOCALHOST\|$TOMCAT_WORK_CATALINA_LOCALHOST/_\|$TOMCAT_WORK_CATALINA_LOCALHOST/marketplace-portlet\|$TOMCAT_WORK_CATALINA_LOCALHOST/notifications-portlet\|$TOMCAT_WORK_CATALINA_LOCALHOST/resources-importer-web\|$TOMCAT_WORK_CATALINA_LOCALHOST/tunnel-web\)" -exec rm -r {} \;

		TOMCAT_CONF_CATALINA_LOCALHOST=$TOMCAT/conf/Catalina/localhost
		gfind $TOMCAT_CONF_CATALINA_LOCALHOST -maxdepth 1 ! -regex "\($TOMCAT_CONF_CATALINA_LOCALHOST\|$TOMCAT_CONF_CATALINA_LOCALHOST/ROOT.xml\|$TOMCAT_CONF_CATALINA_LOCALHOST/marketplace-portlet.xml\|$TOMCAT_CONF_CATALINA_LOCALHOST/notifications-portlet.xml\|$TOMCAT_CONF_CATALINA_LOCALHOST/resources-importer-web.xml\|$TOMCAT_CONF_CATALINA_LOCALHOST/tunnel-web.xml\)" -exec rm -r {} \;

		cp ../license/license-portaldevelopment-developer-6.0sp2-liferaycom.xml deploy/
	fi
fi

if [[ "${PWD##*/}" != *"7.0"* ]]; then
	export JAVA_HOME=$(/usr/libexec/java_home -v 1.6)
	export PATH=$JAVA_HOME/bin:$PATH
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

