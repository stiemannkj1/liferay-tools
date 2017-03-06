#!/bin/bash

################################################################################
#
# Copyright (c) 2000-2017 Liferay, Inc. All rights reserved.
#
# This library is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free
# Software Foundation; either version 2.1 of the License, or (at your option)
# any later version.
#
# This library is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
# details.
#
################################################################################

cd ~/Tools/my-tools
printf '#!/bin/bash\n'"$(cat ~/Tools/license.txt | perl -p -e "s/\\$\{CURRENT_YEAR\}/$(date +'%Y')/g")"'\n\n'"$1"'\n' > "$2"
chmod +x "$2"
git add -f "$2"
