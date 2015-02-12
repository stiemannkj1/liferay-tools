#!/bin/sh

if [ ! -z "$1" ] && [ -e "$1" ]; then
	FORMAT_DIR="$1"
else
	FORMAT_DIR="./"
fi

if [ -f "$1" ]; then
	FORMAT_DIR=$(mktemp -d -t "liferay-formatter")
	trap "rm -rf '$FORMAT_DIR'" SIGINT SIGTERM EXIT
	cp "$1" "$FORMAT_DIR"
fi

BUNDLE_TOMCAT=$(find "$HOME/Portals/liferay.com/build" -name "tomcat-*" | head -1)
SOURCE="$HOME/Projects/liferay.com/portal/master"

(
	cd "$FORMAT_DIR"
	java -cp "$BUNDLE_TOMCAT/webapps/ROOT/WEB-INF/lib/*:$BUNDLE_TOMCAT/lib/ext/*:$SOURCE/portal-service/*" com.liferay.portal.tools.sourceformatter.SourceFormatter
)

if [ -f "$1" ]; then
	FORMATTED_FILES=("$FORMAT_DIR"/*)
	cp "${FORMATTED_FILES[0]}" "$1"
fi
