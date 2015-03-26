#!/opt/local/bin/bash

CATALINA_SH=$(find . -name "tomcat-*" | head -1)/bin/catalina.sh

if [ -n "$1" ] && [[ "$1" == "jrebel" ]]; then
	# jrebel.jar is symlinked to the NetBeans version of jrebel.jar via the following command:
	# ln -s "/Applications/NetBeans/NetBeans 8.0.app/Contents/Resources/NetBeans/java2/jrebel/jrebel.jar" .jrebel/jrebel.jar
	export JAVA_OPTS="$JAVA_OPTS -javaagent:/Users/kylestiemann/.jrebel/jrebel.jar"
	$CATALINA_SH start
elif [ -n "$1" ] && [[ "$1" == "debug" ]]; then
	$CATALINA_SH jpda start
else
	$CATALINA_SH start
fi

