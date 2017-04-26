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

MVN_OUTPUT=$(mvn clean package 2>&1)

if [[ $MVN_OUTPUT == *"COMPILATION ERROR"* ]]; then
    printf "$MVN_OUTPUT" | \
        perl -0 -pe 's/[\S\s]*COMPILATION ERROR([\S\s]*)BUILD FAILURE[\S\s]*/$1/' | \
        grep '^\[ERROR\]' | \
        perl -pe 's/^\[ERROR\] //' | \
        perl -pe 's/\[([0-9]+)[\S\s]*$/$1\n/'
fi
