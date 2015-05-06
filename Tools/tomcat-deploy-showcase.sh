#!/opt/local/bin/bash

LAST_RUN_TIME_STAMP_FILE=~/Tools/.tomcat-deploy.sh.lastrun
TOMCAT_WEBAPPS=~/Servers/apache-tomcat-7.0.56/webapps

echo "Removing showcase files from Tomcat."
rm -rf "$TOMCAT_WEBAPPS"/showcase-webapp-4.2.0-*

if [[ "$@" == *u* || $(find "$LIFERAY_FACES/util" -mnewer "$LAST_RUN_TIME_STAMP_FILE" |  head -n 1) ]]
then
	mvn install -f "$LIFERAY_FACES/util/pom.xml"
fi

if [[ "$@" == *a* || $(find "$LIFERAY_FACES/alloy" -mnewer "$LAST_RUN_TIME_STAMP_FILE" | head -n 1) ]]
then
	mvn install -f "$LIFERAY_FACES/alloy/pom.xml"
fi

SHOWCASE_WEBAPP=$LIFERAY_FACES/demos/showcase/showcase-webapp

cd "$SHOWCASE_WEBAPP"
mvn install -P development
echo "Copying showcase.war to Tomcat."
cp "$SHOWCASE_WEBAPP"/target/showcase-webapp-*-SNAPSHOT.war "$TOMCAT_WEBAPPS/"
touch "$LAST_RUN_TIME_STAMP_FILE"
echo "Done."

growl.scpt "Deployed Showcase to Tomcat."
