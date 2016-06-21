#!/opt/local/bin/bash

TOMCAT_WEBAPPS=/Users/kylestiemann/Servers/apache-tomcat-7.0.62/webapps

echo "Removing $TOMCAT_WEBAPPS/${PWD##*/}* ..."
rm -rf $TOMCAT_WEBAPPS/${PWD##*/}*
echo "Done."

echo "Building..."
if [ $# -eq 0 ]; then
	mvn clean install -P prettyfaces,development,jsf22
else
	mvn clean install $@
fi
echo "Done."

echo "Copying" target/*.war "to $TOMCAT_WEBAPPS/ ..."
cp target/*.war $TOMCAT_WEBAPPS/
echo "Done."

if [ $# -eq 0 ] || [[ $@ == *"prettyfaces"* ]]; then
	echo "Rebuilding without prettyfaces to avoid issues if this war is used as an overlay."
	mvn clean install
fi

growl-complete.sh
