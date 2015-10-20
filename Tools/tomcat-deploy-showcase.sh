#!/opt/local/bin/bash

LAST_RUN_TIME_STAMP_FILE=~/Tools/.tomcat-deploy.sh.lastrun
TOMCAT_WEBAPPS=~/Servers/apache-tomcat-7.0.56/webapps

echo "Removing showcase files from Tomcat."

VERSION=$(xml-strings ~/Projects/liferay.com/liferay-faces-alloy/pom.xml :/project/version)

rm -rf "$TOMCAT_WEBAPPS"/showcase-webapp-$VERSION-*

if [[ $(gfind "./" -newer "$LAST_RUN_TIME_STAMP_FILE" | head -n 1) ]]; then
	mvn clean install
fi

SHOWCASE_WEBAPP=./demos/showcase/showcase-webapp

cd "$SHOWCASE_WEBAPP"
mvn clean install -P "$1"
echo "Copying showcase.war to Tomcat."
cp ./target/showcase-webapp-*-SNAPSHOT.war "$TOMCAT_WEBAPPS/"
touch "$LAST_RUN_TIME_STAMP_FILE"
echo "Done."

growl.scpt "Deployed Showcase to Tomcat."
