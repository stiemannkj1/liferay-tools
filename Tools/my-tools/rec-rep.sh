#!/opt/local/bin/bash

for ARG in "$@"; do
    if [ "$ARG" == '-Q' ] || [ "$ARG" == '--literal' ]; then
		AG_LITERAL='--literal'
		PERL_LITERAL='\Q'
	elif [ "$ARG" == '-0' ] || [ "$ARG" == '--multiline' ]; then
		# ag does multiline searches by default
		PERL_MULTILINE='-0'
	elif [ -z "$SEARCH" ]; then
		SEARCH="$ARG"
	else
		REPLACE="$ARG"
	fi
done

if [ -z "$SEARCH" ]; then
	echo 'You must specify a search regex or literal.'
	exit 1
fi

FILES=$(ag --files-with-matches $AG_LITERAL "$SEARCH")

if [ -n "$FILES" ]; then
	SEARCH="${SEARCH//,/\\,}"
	REPLACE="${REPLACE//,/\\,}"
	perl $PERL_MULTILINE -p -i -e "s,$PERL_LITERAL$SEARCH,$REPLACE,g" $FILES
	echo "$FILES"
fi
