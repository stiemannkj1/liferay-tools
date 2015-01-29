#!/opt/local/bin/bash

LAST_RUN_TIME_STAMP_FILE=$HOME/Tools/my-tools/.tomcat-deploy.sh.lastrun
TOMCAT_WEBAPPS=$HOME/Servers/apache-tomcat-7.0.56/webapps
TOMCAT_SHOWCASE=$TOMCAT_WEBAPPS/showcase-webapp-4.2.0-beta1-SNAPSHOT

echo "Removing showcase files from Tomcat."
rm -rf "$TOMCAT_SHOWCASE/"
rm -rf "$TOMCAT_SHOWCASE.war"

LIFERAY_FACES_MASTER=$HOME/Projects/liferay.com/liferay-faces-master

if [[ "$@" == *u* || $(find "$LIFERAY_FACES_MASTER/util" -mnewer "$LAST_RUN_TIME_STAMP_FILE" |  head -n 1) ]]
then
	mvn install -f "$LIFERAY_FACES_MASTER/util/pom.xml"
fi

if [[ "$@" == *a* || $(find "$LIFERAY_FACES_MASTER/alloy" -mnewer "$LAST_RUN_TIME_STAMP_FILE" | head -n 1) ]]
then
	mvn install -f "$LIFERAY_FACES_MASTER/alloy/pom.xml"
fi

SHOWCASE_WEBAPP=$LIFERAY_FACES_MASTER/demos/showcase/showcase-webapp

cd "$SHOWCASE_WEBAPP"
mvn install -P development
echo "Copying showcase.war to Tomcat."
cp "$SHOWCASE_WEBAPP/target/showcase-webapp-4.2.0-beta1-SNAPSHOT.war" "$TOMCAT_WEBAPPS/"
echo "Done."

touch "$LAST_RUN_TIME_STAMP_FILE"
