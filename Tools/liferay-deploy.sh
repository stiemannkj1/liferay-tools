#!/opt/local/bin/bash

PORTALS_HOME="$HOME/Portals"
LIFERAY_VERSION=$(xml-strings ./pom.xml :/project/properties/liferay.version)

JSF_VERSION=$(xml-strings ./pom.xml :/project/properties/faces.spec.version)

if [[ $@ == *"jsf22"* ]]; then
	JSF_VERSION=2.2
fi

for portlet in $(gfind "./demos" "./issues" -maxdepth 2 -name *-portlet | egrep "$1"); do

	if [ -e "$portlet/pom.xml" ]; then
		pushd $portlet && deploy.sh "${@:2}" development
		mv ~/Portals/liferay.com/liferay-portal-$LIFERAY_VERSION-jsf-$JSF_VERSION/deploy/${portlet##*/}* ~/Portals/liferay.com/${LIFERAY_VERSION:0:3}/deploy/
		echo "Moving ~/Portals/liferay.com/liferay-portal-$LIFERAY_VERSION-jsf-$JSF_VERSION/deploy/${portlet##*/}* to ~/Portals/liferay.com/${LIFERAY_VERSION:0:3}/deploy/"
		popd
	else
		echo "$portlet missing pom.xml. Ignoring."
	fi
done

if [[ tck =~ $1 ]]; then

	pushd  ~/Projects/liferay.com/liferay-faces-bridge-impl/test/bridge-tck/bridge-tck-main-portlet && deploy.sh "${@:2}" development
	mv ~/Portals/liferay.com/liferay-portal-$LIFERAY_VERSION-jsf-$JSF_VERSION/deploy/bridge-tck-main-portlet* ~/Portals/liferay.com/${LIFERAY_VERSION:0:3}/deploy/
	echo "Moving ~/Portals/liferay.com/liferay-portal-$LIFERAY_VERSION-jsf-$JSF_VERSION/bridge-tck-main-portlet* to ~/Portals/liferay.com/${LIFERAY_VERSION:0:3}/deploy/"
	popd
fi

if [[ test-setup-hook =~ $1 ]]; then

	pushd ~/Projects/liferay.com/liferay-faces-portal/test/test-setup-hook && deploy.sh "${@:2}" development
	mv ~/Portals/liferay.com/liferay-portal-$LIFERAY_VERSION-jsf-$JSF_VERSION/deploy/test-setup-hook* ~/Portals/liferay.com/${LIFERAY_VERSION:0:3}/deploy/
	echo "Moving ~/Portals/liferay.com/liferay-portal-$LIFERAY_VERSION-jsf-$JSF_VERSION/deploy/test-setup-hook* to ~/Portals/liferay.com/${LIFERAY_VERSION:0:3}/deploy/"
	popd
fi
