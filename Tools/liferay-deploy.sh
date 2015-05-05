#!/opt/local/bin/bash

if [ ! -e pom.xml ]; then
	echo "${PWD##*/} missing pom.xml. Ignoring."
	exit 0
fi

VERSION="$2"

if [ -z "$VERSION" ]; then
	VERSION="$(xml-strings ~/Projects/liferay.com/faces/master/pom.xml :/project/properties/liferay.version)"
	VERSION="${VERSION:0:3}"
fi

LIFERAY_PORTAL=~/Portals/liferay.com/$VERSION$1

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
mvn clean install -P development${2/-/,},tomcat
echo "Done."

echo "Copying" target/*.war "to $LIFERAY_PORTAL/deploy/ ..."
cp target/*.war $LIFERAY_PORTAL/deploy/
echo "Done."
