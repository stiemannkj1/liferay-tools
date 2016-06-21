#!/opt/local/bin/bash

for portlet in $(gfind "./demo" "./demos" "./issue" "./issues" -maxdepth 2 -name *-portlet | egrep "$1"); do

	if [ -e "$portlet/pom.xml" ]; then
		(cd $portlet && deploy.sh "${@:2}" development)
	else
		echo "$portlet missing pom.xml. Ignoring."
	fi
done

if [[ tck =~ $1 ]]; then
	(cd ~/Projects/liferay.com/liferay-faces-bridge-impl/tck/bridge-tck-main-portlet && deploy.sh "${@:2}" development)
fi

if [[ test-setup-hook =~ $1 ]]; then
	(cd ~/Projects/liferay.com/liferay-faces-portal/test/test-setup-hook && deploy.sh "${@:2}" development)
fi
