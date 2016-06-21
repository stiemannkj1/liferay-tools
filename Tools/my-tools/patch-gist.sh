#!/opt/local/bin/bash

DESCRIPTION="No Description."

if [[ ! -z "$2" ]]; then
	DESCRIPTION="$2"
fi

gist -p -d "$DESCRIPTION" -f "$(basename "$1")" < "$1"
