#!/opt/local/bin/bash

LIFERAY_VERSION=$(xml-strings $LIFERAY_FACES/pom.xml :/project/properties/liferay.version)
JSF_VERSION=$(xml-strings $LIFERAY_FACES/pom.xml :/project/properties/faces.spec.version)

for portlet in $(gfind "$LIFERAY_FACES/demos" "$LIFERAY_FACES/issues" -maxdepth 2 -name *-portlet | egrep "$1"); do

	if [[ $portlet =~ icefaces3-chat-portlet ]]; then
		echo "Skipping $portlet."
	elif [ -e "$portlet/pom.xml" ]; then
		cd $portlet && deploy.sh "${@:2}"
		mv ~/Portals/liferay.com/liferay-portal-$LIFERAY_VERSION-jsf-$JSF_VERSION/deploy/${portlet##*/}* ~/Portals/liferay.com/${LIFERAY_VERSION:0:3}/deploy/
		echo "Moving ~/Portals/liferay.com/liferay-portal-$LIFERAY_VERSION-jsf-$JSF_VERSION/deploy/${portlet##*/}* to ~/Portals/liferay.com/${LIFERAY_VERSION:0:3}/deploy/"
	else
		echo "$portlet missing pom.xml. Ignoring."
	fi
done

if [[ tck =~ $1 ]]; then

	cd $LIFERAY_FACES/test/bridge-tck/bridge-tck-main-portlet && deploy.sh "${@:2}"
	mv ~/Portals/liferay.com/liferay-portal-$LIFERAY_VERSION-jsf-$JSF_VERSION/deploy/bridge-tck-main-portlet* ~/Portals/liferay.com/${LIFERAY_VERSION:0:3}/deploy/
	echo "Moving ~/Portals/liferay.com/liferay-portal-$LIFERAY_VERSION-jsf-$JSF_VERSION/bridge-tck-main-portlet* to ~/Portals/liferay.com/${LIFERAY_VERSION:0:3}/deploy/"
fi

if [[ test-setup-hook =~ $1 ]]; then

	cd $LIFERAY_FACES/test/test-setup-hook && deploy.sh "${@:2}"
	mv ~/Portals/liferay.com/liferay-portal-$LIFERAY_VERSION-jsf-$JSF_VERSION/deploy/test-setup-hook* ~/Portals/liferay.com/${LIFERAY_VERSION:0:3}/deploy/
	echo "Moving ~/Portals/liferay.com/liferay-portal-$LIFERAY_VERSION-jsf-$JSF_VERSION/deploy/test-setup-hook* to ~/Portals/liferay.com/${LIFERAY_VERSION:0:3}/deploy/"
fi
