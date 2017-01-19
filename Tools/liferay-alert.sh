#!/opt/local/bin/bash

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

CATALINA_OUT=$(find . -name "tomcat-*" | head -1)/logs/catalina.out

tail -n 0 -f $CATALINA_OUT | tee /dev/tty | grep -q "org[.]apache[.]catalina[.]startup[.]Catalina start" && growl.sh "Liferay Started."

while true; do
	tail -n 0 -f $CATALINA_OUT | tee /dev/tty | grep -q " for .* is available for use" && growl.sh "Portlet Available for Use."
done

