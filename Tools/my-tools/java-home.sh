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

JAVA_HOME=$(printf '%s\n' /home/kylestiemann/Tools/jdk1.8* | tail -1)

if [[ "$1" == *7* ]]; then
	JAVA_HOME=$(printf '%s\n' /home/kylestiemann/Tools/jdk1.7* | tail -1)
elif [[ "$1" == *6* ]]; then
	JAVA_HOME=$(printf '%s\n' /home/kylestiemann/Tools/jdk1.6* | tail -1)
	MAVEN_HOME=/home/kylestiemann/Tools/apache-maven-3.1.1/bin
elif [[ "$1" == *5* ]]; then
	JAVA_HOME=$(printf '%s\n' /home/kylestiemann/Tools/jdk1.5* | tail -1)
	MAVEN_HOME=/home/kylestiemann/Tools/apache-maven-3.1.1/bin
fi

if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
	export JAVA_HOME
	export MAVEN_HOME
	export PATH=$JAVA_HOME/bin:$MAVEN_HOME:$PATH
else
	echo $JAVA_HOME
fi
