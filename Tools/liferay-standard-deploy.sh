#!/opt/local/bin/bash

LIFERAY_VERSION=$(xml-strings $LIFERAY_FACES/pom.xml :/project/properties/liferay.version)
JSF_VERSION=$(xml-strings $LIFERAY_FACES/pom.xml :/project/properties/faces.spec.version)

for portlet in $(gfind "$LIFERAY_FACES/demos" "$LIFERAY_FACES/issues" -name *-portlet | egrep $1); do
	cd $portlet && deploy.sh "${@:2}"
done

if [[ test-setup-hook =~ "$1" ]]; then
	cd $LIFERAY_FACES/test/test-setup-hook && deploy.sh "${@:2}"
fi
