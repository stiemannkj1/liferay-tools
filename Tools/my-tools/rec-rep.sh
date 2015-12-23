#!/opt/local/bin/bash

if [ "$1" == '-Q' ]; then
	AG_LITERAL="--literal"
	PERL_LITERAL="\Q"
	SEARCH="$2"
	REPLACE="$3"
else
	SEARCH="$1"
	REPLACE="$2"
fi

FILES=$(ag --files-with-matches $AG_LITERAL "$SEARCH")

if [ -n "$FILES" ]; then
	SEARCH="${SEARCH//,/\\,}"
	REPLACE="${REPLACE//,/\\,}"
	perl -0p -i -e "s,$PERL_LITERAL$SEARCH,$REPLACE,g" $FILES
	echo "$FILES"
fi
