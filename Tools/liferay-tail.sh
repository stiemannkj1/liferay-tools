#!/opt/local/bin/bash

CATALINA_OUT=$(find . -name "tomcat-*" | head -1)/logs/catalina.out

tail -n 0 -f $CATALINA_OUT | tee /dev/tty | grep -q "INFO: Server startup in " && growl.scpt "Liferay Started."

while true; do
	tail -n 0 -f $CATALINA_OUT | tee /dev/tty | grep -q " for .* is available for use" && growl.scpt "Portlet Available for Use."
done

