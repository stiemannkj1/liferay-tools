#!/opt/local/bin/bash

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

LIFERAY_PORTAL=$PORTALS_HOME/liferay.com/$VERSION$2

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