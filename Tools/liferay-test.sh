#!/opt/local/bin/bash

LIFERAY_FACES_TEST_INTEGRATION="$LIFERAY_FACES/test/integration"

for test in $(gfind "$LIFERAY_FACES_TEST_INTEGRATION/demos" "$LIFERAY_FACES_TEST_INTEGRATION/issues" -maxdepth 2 -regex ".*\(-portlet\|-resources\)" | egrep "$1"); do
	cd $test && mvn test -P integration
done
