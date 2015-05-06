#!/opt/local/bin/bash

LIFERAY_FACES_TEST_INTEGRATION="$LIFERAY_FACES/test/integration"

for portlet in $(find "$LIFERAY_FACES_TEST_INTEGRATION/demos" "$LIFERAY_FACES_TEST_INTEGRATION/issues" -name *-portlet | egrep $1); do
	cd $portlet && mvn test -P integration
done
