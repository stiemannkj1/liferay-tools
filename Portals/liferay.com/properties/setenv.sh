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

# This file is symlinked in every portal/ folder using the following command:
# for folder in [0-9].[0-9]?(-ee); do (cd $folder/tomcat-*/bin && rm setenv.sh; ln -s /Users/kylestiemann/Portals/liferay.com/properties/setenv.sh setenv.sh); done
JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF8 -Djava.net.preferIPv4Stack=true  -Dorg.apache.catalina.loader.WebappClassLoader.ENABLE_CLEAR_REFERENCES=false -Duser.timezone=GMT -Xmx3072m -XX:MaxPermSize=1536m -Djava.awt.headless=true"
