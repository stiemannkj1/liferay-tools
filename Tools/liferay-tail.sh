#!/opt/local/bin/bash

tail -n 0 -f ../logs/catalina.out | tee /dev/tty | grep -q "INFO: Server startup" && growl.scpt "Liferay Started."

while true; do
	tail -n 0 -f ../logs/catalina.out | tee /dev/tty | grep -q ".* is available for use" && growl.scpt "Portlet Available for Use."
done

