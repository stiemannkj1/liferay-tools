#!/opt/local/bin/bash

DIRS_TO_SEARCH=()

if [ -d "./demo" ]; then
	DIRS_TO_SEARCH+=("./demo")
fi

if [ -d "./demos" ]; then
	DIRS_TO_SEARCH+=("./demos")
fi

if [ -d "./issue" ]; then
	DIRS_TO_SEARCH+=("./issue")
fi

if [ -d "./issues" ]; then
	DIRS_TO_SEARCH+=("./issues")
fi

if [ -d "./bridge" ]; then
	DIRS_TO_SEARCH+=("./bridge")
fi

if [ -d "./bridge-ext" ]; then
	DIRS_TO_SEARCH+=("./bridge-ext")
fi

if [ -d "./site" ]; then
	DIRS_TO_SEARCH+=("./site")
fi

if [ ${#DIRS_TO_SEARCH[@]} -eq 0 ]; then
	echo "Error: no demos to deploy."
	exit 1
fi

for portlet in $(gfind "${DIRS_TO_SEARCH[@]}" -maxdepth 2 -name *-portlet | egrep "$1"); do

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
