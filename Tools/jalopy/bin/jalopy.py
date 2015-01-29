#!/usr/bin/python
# Copyright 2003-2005 TRIEMAX Software. All rights reserved.
#
# Startup script for the Jalopy Source Code Formatter console Plug-in. This
# script assumes the following directory structure:
#
#   <JALOPY_DIR>
#      /bin          contains this script
#      /lib          contains the Jalopy runtime library
#

import os, os.path, string, sys


if os.environ.has_key("JAVA_HOME") and os.environ["JAVA_HOME"] != "":
    JAVA_HOME = os.environ["JAVA_HOME"]
else:
    print "\nWarning: JAVA_HOME environment variable is not set.\n" \
          "You may need to set the JAVA_HOME environment variable\n" \
          "to the installation directory of Java.\n" \

# check to make sure environment is setup
if not os.environ.has_key("JAVACMD"):
    JAVACMD = os.path.normpath(JAVA_HOME + "/bin/java")
else:
    JAVACMD = os.environ["JAVACMD"]

# build classpath
LIBDIR = os.path.join(os.path.dirname(sys.path[0]), "lib")

jarfiles = []
for file in os.listdir(LIBDIR):
    if file[-4:] == ".jar":
        jarfiles.append(os.path.join(LIBDIR, file))

# determine the separator char for the platform
SEPARATOR = ":"
if os.name == "dos" or os.name == "nt":
    SEPARATOR = ";"

localpath = string.join(jarfiles, SEPARATOR)

# build the commandline
cmdline = '%s -classpath "%s" Jalopy %s' \
     % (JAVACMD, localpath, string.join(sys.argv[1:], " "))

# run Jalopy
returnCode = os.system(cmdline)

# sys.exit(returnCode);
