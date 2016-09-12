#!/opt/local/bin/bash

echo "Building..."
if [ $# -eq 0 ]; then
	mvn clean install -P prettyfaces,development,jsf22
else
	mvn clean install $@
fi
echo "Done."

WAR_WITH_VERSION=$(fff.sh '[.]war' ./target/)
WAR_WITH_VERSION=${WAR_WITH_VERSION##*/}
WAR_NAME=${WAR_WITH_VERSION//-[0-9][0-9.]*-[A-Za-z0-9][A-Za-z0-9_]*[.]war}

TOMCAT_WEBAPPS=/Users/kylestiemann/Servers/apache-tomcat-8.0.32/webapps
echo "Removing $TOMCAT_WEBAPPS/$WAR_NAME* ..."
rm -r $TOMCAT_WEBAPPS/$WAR_NAME*
echo "Done."

echo "Copying target/$WAR_WITH_VERSION to $TOMCAT_WEBAPPS/$WAR_NAME.war ..."
cp target/$WAR_WITH_VERSION $TOMCAT_WEBAPPS/$WAR_NAME.war
echo "Done."

growl-complete.sh
