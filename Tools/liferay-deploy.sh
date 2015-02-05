#!/opt/local/bin/bash

if [ -n "$1" ]; then
	VERSION=$1
else
	VERSION=master
fi

LIFERAY_PORTAL=$PORTALS_HOME/liferay.com/$VERSION/liferay-portal$2

if [ ! -e "$LIFERAY_PORTAL" ]; then
	echo "DEPLOYMENT FAILED! $LIFERAY_PORTAL does not exist!"
	growl.scpt "DEPLOYMENT FAILED!"
	exit 1
fi

LIFERAY_TOMCAT_WEBAPPS=$(find $LIFERAY_PORTAL -name "tomcat-*" | head -1)/webapps

echo "Removing $LIFERAY_TOMCAT_WEBAPPS/${PWD##*/} ..."
rm -rf $LIFERAY_TOMCAT_WEBAPPS/${PWD##*/}
echo "Done."

echo "Building..."
mvn clean install
echo "Done."

echo "Copying" target/*.war "to $LIFERAY_PORTAL/deploy/ ..."
cp target/*.war $LIFERAY_PORTAL/deploy/
echo "Done."

growl.scpt "Deployment Completed."
