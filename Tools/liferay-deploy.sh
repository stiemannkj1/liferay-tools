#!/opt/local/bin/bash

if [ ! -e pom.xml ]; then
	echo "${PWD##*/} missing pom.xml. Ignoring."
	exit 0
fi

case $1 in
	*.2.x)
		VERSION="6.2"
	;;
	*.1.x)
		VERSION="6.1"
	;;
	*.0.x)
		VERSION="6.0"
	;;
	*.0.x-legacy)
		VERSION="5.2"
	;;
	"" | *)
		VERSION="master"
	;;
esac

LIFERAY_PORTAL=~/Portals/liferay.com/$VERSION$2

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
mvn clean install -P development
echo "Done."

echo "Copying" target/*.war "to $LIFERAY_PORTAL/deploy/ ..."
cp target/*.war $LIFERAY_PORTAL/deploy/
echo "Done."
