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

cd ~/Portals/liferay.com/liferay-portal-6.2.0-jsf-2.1/tomcat-7.0.42
mvn install:install-file -Dfile=lib/ext/portal-service.jar -DgroupId=com.liferay.portal -DartifactId=portal-service -Dpackaging=jar -DgeneratePom=true -Dversion=6.2.0-ga1
mvn install:install-file -Dfile=webapps/ROOT/WEB-INF/lib/portal-impl.jar -DgroupId=com.liferay.portal -DartifactId=portal-impl -Dpackaging=jar -DgeneratePom=true -Dversion=6.2.0-ga1
mvn install:install-file -Dfile=webapps/ROOT/WEB-INF/lib/util-bridges.jar -DgroupId=com.liferay.portal -DartifactId=util-bridges -Dpackaging=jar -DgeneratePom=true -Dversion=6.2.0-ga1
mvn install:install-file -Dfile=webapps/ROOT/WEB-INF/lib/util-java.jar -DgroupId=com.liferay.portal -DartifactId=util-java -Dpackaging=jar -DgeneratePom=true -Dversion=6.2.0-ga1
mvn install:install-file -Dfile=webapps/ROOT/WEB-INF/lib/util-taglib.jar -DgroupId=com.liferay.portal -DartifactId=util-taglib -Dpackaging=jar -DgeneratePom=true -Dversion=6.2.0-ga1
