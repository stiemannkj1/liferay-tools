#!/opt/local/bin/bash

TOMCAT_WEBAPPS=/Users/kylestiemann/Servers/apache-tomcat-7.0.56/webapps

echo "Removing $TOMCAT_WEBAPPS/${PWD##*/}* ..."
rm -rf $TOMCAT_WEBAPPS/${PWD##*/}*
echo "Done."

echo "Building..."
mvn clean install $@
echo "Done."

echo "Copying" target/*.war "to $TOMCAT_WEBAPPS/ ..."
cp target/*.war $TOMCAT_WEBAPPS/
echo "Done."

growl.scpt "Process Completed."
