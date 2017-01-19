#!/opt/local/bin/bash

cd ~/Tools/my-tools
printf '#!/opt/local/bin/bash\n\n\n'"$1"'\n' > "$2"
chmod +x "$2"
git add -f "$2"
