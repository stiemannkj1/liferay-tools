#!/opt/local/bin/bash

echo mvn test -P integration -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=phantomjs &&
mvn test -P integration -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=phantomjs &&
echo mvn test -P integration -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=firefox &&
mvn test -P integration -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=firefox &&
echo mvn test -P integration -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=chrome &&
mvn test -P integration -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=chrome &&
echo mvn test -P integration,liferay -Dtest="$1" -Dintegration.browser=phantomjs &&
mvn test -P integration,liferay -Dtest="$1" -Dintegration.browser=phantomjs &&
echo mvn test -P integration,liferay -Dtest="$1" -Dintegration.browser=firefox &&
mvn test -P integration,liferay -Dtest="$1" -Dintegration.browser=firefox &&
echo mvn test -P integration,liferay -Dtest="$1" -Dintegration.browser=chrome &&
mvn test -P integration,liferay -Dtest="$1" -Dintegration.browser=chrome &&
echo mvn test -P integration,pluto -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=phantomjs &&
mvn test -P integration,pluto -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=phantomjs &&
echo mvn test -P integration,pluto -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=firefox &&
mvn test -P integration,pluto -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=firefox &&
echo mvn test -P integration,pluto -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=chrome &&
mvn test -P integration,pluto -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=chrome &&
echo mvn test -P integration,alloy -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=phantomjs &&
mvn test -P integration,alloy -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=phantomjs &&
echo mvn test -P integration,alloy -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=firefox &&
mvn test -P integration,alloy -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=firefox &&
echo mvn test -P integration,alloy -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=chrome &&
mvn test -P integration,alloy -Dintegration.port=8181 -Dtest="$1" -Dintegration.browser=chrome &&
echo mvn test -P integration,liferay-alloy -Dtest="$1" -Dintegration.browser=phantomjs &&
mvn test -P integration,liferay-alloy -Dtest="$1" -Dintegration.browser=phantomjs &&
echo mvn test -P integration,liferay-alloy -Dtest="$1" -Dintegration.browser=firefox &&
mvn test -P integration,liferay-alloy -Dtest="$1" -Dintegration.browser=firefox &&
echo mvn test -P integration,liferay-alloy -Dtest="$1" -Dintegration.browser=chrome &&
mvn test -P integration,liferay-alloy -Dtest="$1" -Dintegration.browser=chrome &&
echo mvn test -P integration,pluto-alloy -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=phantomjs &&
mvn test -P integration,pluto-alloy -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=phantomjs &&
echo mvn test -P integration,pluto-alloy -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=firefox &&
mvn test -P integration,pluto-alloy -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=firefox &&
echo mvn test -P integration,pluto-alloy -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=chrome &&
mvn test -P integration,pluto-alloy -Dintegration.port=8180 -Dtest="$1" -Dintegration.browser=chrome
