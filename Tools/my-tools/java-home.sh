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

JAVA_HOME=$(echo /home/kylestiemann/Tools/jdk1.8*)

if [[ "$1" == *7* ]]; then
	JAVA_HOME=$(echo /home/kylestiemann/Tools/jdk1.7*)
elif [[ "$1" == *6* ]]; then
	JAVA_HOME=$(echo /home/kylestiemann/Tools/jdk1.6*)
elif [[ "$1" == *5* ]]; then
	JAVA_HOME=$(echo /home/kylestiemann/Tools/jdk1.5*)
fi

if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
	export JAVA_HOME
	export PATH=$JAVA_HOME/bin:$PATH
else
	echo $JAVA_HOME
fi
