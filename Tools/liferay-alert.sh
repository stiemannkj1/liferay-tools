#!/opt/local/bin/bash

CATALINA_OUT=$(find . -name "tomcat-*" | head -1)/logs/catalina.out

tail -n 0 -f $CATALINA_OUT | tee /dev/tty | grep -q "org[.]apache[.]catalina[.]startup[.]Catalina start" && growl.sh "Liferay Started."

while true; do
	tail -n 0 -f $CATALINA_OUT | tee /dev/tty | grep -q " for .* is available for use" && growl.sh "Portlet Available for Use."
done

