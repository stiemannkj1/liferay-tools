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

BUNDLE_TOMCAT=$(find "$HOME/Portals/liferay.com/build" -name "tomcat-*" | head -1)
SOURCE="$HOME/Projects/liferay.com/portal/master"

(
	cd "$FORMAT_DIR"
	java -cp "$BUNDLE_TOMCAT/webapps/ROOT/WEB-INF/lib/*:$BUNDLE_TOMCAT/lib/ext/*:$SOURCE/portal-service/*" com.liferay.portal.tools.sourceformatter.SourceFormatter
)

if [ -f "$1" ]; then
	FORMATTED_FILES=("$TMPDIR"/*)
	cp "${FORMATTED_FILES[0]}" "$1"
	rm -rf "$TMPDIR"
fi
