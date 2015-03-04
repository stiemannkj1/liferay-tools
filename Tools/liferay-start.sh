#!/opt/local/bin/bash

if [ -n "$1" ] && [[ "$1" == "jrebel" ]]; then
	# jrebel.jar is symlinked to the NetBeans version of jrebel.jar via the following command:
	# ln -s "/Applications/NetBeans/NetBeans 8.0.app/Contents/Resources/NetBeans/java2/jrebel/jrebel.jar" .jrebel/jrebel.jar
	export JAVA_OPTS="$JAVA_OPTS -javaagent:/Users/kylestiemann/.jrebel/jrebel.jar"
	./catalina.sh start
elif [ -n "$1" ] && [[ "$1" == "debug" ]]; then
	./catalina.sh jpda start
else
	./catalina.sh start
fi
