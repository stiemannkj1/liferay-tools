#!/opt/local/bin/bash

if [ -n "$1" ] && [[ "$1" == "jrebel" ]]; then
	export JAVA_OPTS="$JAVA_OPTS -javaagent:/Users/kylestiemann/.jrebel/jrebel.jar"
	./catalina.sh start
elif [ -n "$1" ] && [[ "$1" == "debug" ]]; then
	./catalina.sh jpda start
else
	./catalina.sh start
fi
