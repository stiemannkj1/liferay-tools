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

case "$PWD" in
	*liferay-faces-bridge-impl*|\
		*liferay-faces-bridge-api*|\
		*liferay-faces-showcase*|\
		*liferay-faces-test-selenium*|\
		*liferay-faces-util*)
		PROFILE_ARG="--profile=liferay-faces-apache-2.0"
	;;
	*)
		PROFILE_ARG="--profile=liferay-faces"
	;;
esac

~/Tools/jalopy-1.9.5/bin/jalopy.sh $PROFILE_ARG "$@"
