#!/opt/local/bin/bash

printf "\nUnedited Message Contained:\n\n"
cat "$1" | gsed '/^#/ d'
