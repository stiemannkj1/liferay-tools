################################################################################
#
# Copyright (c) 2000-2016 Liferay, Inc. All rights reserved.
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

#!/bin/sh

cd /Users/kylestiemann/Portals/liferay.com/liferay-portal-6.2.1-jsf-2.2/tomcat-7.0.42/bin
./jrebel-catalina.sh $1
tail -f /Users/kylestiemann/Portals/liferay.com/liferay-portal-6.2.1-jsf-2.2/tomcat-7.0.42/logs/catalina.out
