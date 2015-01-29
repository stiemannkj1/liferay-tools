#!/bin/sh

if [ ! -z "$1" ] && [ -e "$1" ]; then
	FORMAT_DIR="$1"
else
	FORMAT_DIR="./"
fi

if [ -f "$1" ]; then
	TMPDIR="$HOME/temp/liferay-formatter"
	mkdir "$TMPDIR"
	cp "$1" "$TMPDIR"
	FORMAT_DIR="$TMPDIR"
fi

BUNDLE="$HOME/Portals/liferay.com/liferay-portal-7.0.0-SNAPSHOT-JSF-2.2"
SOURCE="$HOME/Projects/liferay.com/liferay-portal/liferay-portal-master"

(
	cd "$FORMAT_DIR"
	java -cp "$BUNDLE/tomcat-7.0.42/webapps/ROOT/WEB-INF/lib/*:$BUNDLE/tomcat-7.0.42/lib/ext/*:$SOURCE/portal-service/*" com.liferay.portal.tools.sourceformatter.SourceFormatter
)

if [ -f "$1" ]; then
	FORMATTED_FILES=("$TMPDIR"/*)
	cp "${FORMATTED_FILES[0]}" "$1"
	rm -rf "$TMPDIR"
fi
