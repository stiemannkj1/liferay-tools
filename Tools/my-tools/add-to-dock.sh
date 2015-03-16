# You may need to change this to /bin/bash or another path on your system.
#!/opt/local/bin/bash

# If no arguments have been passed to script, then
if [[ $# == 1 ]]; then
	# printUsage()
	exit 0
fi

while [[ $# > 1 ]]; do

	key="$1"; shift

	case $key in
		-h|--help)
			# printUsage()
			exit 0
		;;
		-f|--file|--folder|--dir)
			# input file or folder
			INPUT="$1"; shift
		;;
# 		-o|--output-dir)
# 			# set the parent-dir of our dock app
# 			# if not set, then determine our permissions level and put our app in /Applications/ or ~/Applications
# 			OUTPUT_DIR="$1"; shift
# 		;;
		-l|--label)
			# optinally set the label
			LABEL="$1"; shift
		;;
		-i|--icon)
			# default icon based on executable, folder, or file
			ICON="$1"; shift
		;;
		*)
			if [[ -z "$INPUT" ]]; then
				INPUT="$1"
			else
				echo "Unknown option: $1"
			fi

			shift
		;;
	esac
done

# Assert that $INPUT file or folder exists.
if [[ -z "$INPUT" ]] || [[ ! -e "$INPUT" ]]; then
	# print error message
	exit 1
fi

# # If $OUTPUT_DIR has not been set, then
# if [[ -z "$OUTPUT_DIR" ]]; then
# 
# 	# If we have permission to write to /Applications, then make /Applications the $OUTPUT_DIR.
# 	if [[ -w "/Applications" ]]; then
# 		OUTPUT_DIR="/Applications"
# 	# Otherwise default to ~/Applications as the $OUTPUT_DIR
# 	else
# 		OUTPUT_DIR="~/Applications"
# 	fi
# fi
# 
# # Assert that $OUTPUT_DIR exists.
# if [[ ! -e "$OUTPUT_DIR" ]]; then
# 	#print error message
# 	exit 1
# fi
# 
# # Assert that $OUTPUT_DIR is a directory.
# if [[ ! -d "$OUTPUT_DIR" ]]; then
# 	# print error message
# 	exit 1
# fi
# 
# # Assert that $OUTPUT_DIR is writable.
# if [[ ! -w "$OUTPUT_DIR" ]]; then
# 	# print error message
# 	exit 1
# fi
# 
# Default $LABEL to $INPUT.
if [[ -z "$LABEL" ]]; then
	LABEL=$(basname "$INPUT")
fi

# Assert that if $ICON has been set, $ICON exists.
if [[ ! -z "$ICON" ]] && [[ ! -e "$ICON" ]]; then
	#print error message
	exit 1
fi

#do icon stuff

FILE_TYPE="0"

if [[ "$INPUT" == "*.app" ]]; then
	FILE_TYPE="41"
	LABEL="${LABEL%.*}"
else if [[ -d "$INPUT" ]]; then
	FILE_TYPE="18"
fi

defaults write com.apple.dock persistent-apps -array-add\
"<dict>
	<key>tile-data</key>
	<dict>
		<key>file-data</key>
		<dict>
			<key>_CFURLString</key>
			<string>$INPUT</string>
			<key>_CFURLStringType</key>
			<integer>0</integer>
		</dict>
		<key>file-label</key>
		<string>$LABEL</string>
		<key>file-type</key>
		<integer>$FILE_TYPE</integer>
# possibly add xml from web here TODO
	</dict>
</dict>"

killall Dock

