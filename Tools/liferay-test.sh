#!/opt/local/bin/bash

LIFERAY_FACES_MASTER="$HOME/Projects/liferay.com/faces/master/test/integration"

for portlet in $(find "$LIFERAY_FACES_MASTER/demos" "$LIFERAY_FACES_MASTER/issues" -name *-portlet | egrep $1); do
	cd $portlet && mvn test -P integration
done
