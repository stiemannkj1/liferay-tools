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

# Enviornment Variables:
export JAVA_HOME=$(/usr/libexec/java_home)
export MAVEN_OPTS="-Xmx1024m -Djava.awt.headless=true"
export ANT_OPTS="-Xmx2048m -Djava.awt.headless=true -XX:MaxPermSize=512m"
export GRADLE_HOME=/opt/local/share/java/gradle
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# TODO Remove this. Fix pluto deployments.
export PORTALS_HOME=$HOME/Portals

# History Settings:
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
shopt -s histappend

# Make nano the default terminal editor:
export EDITOR="/opt/local/bin/vim"
export VISUAL="$EDITOR"

# Path
# /opt/local/bin:\ is first because macports needs to be first on the list.
export PATH=\
/opt/local/bin:\
~/Tools/my-tools:\
/bin:\
/opt/local/sbin:\
/sbin:\
/usr/bin:\
/usr/sbin:\
/usr/local/bin:\
/usr/local/mysql/bin:\
$JAVA_HOME/bin:\
~/Tools:\
~/Tools/vdldoc/bin:\
~/Tools/jd-cli-0.9.1.Final-dist:\
~/Tools/SaxonHE9-6-0-8J:\
~/Tools/phantomjs-2.1.1-macosx/bin:\
~/Projects/liferay.com/liferay-faces-maven

# Support wildcards (*):
shopt -s globstar
# Support inverse wildcards (!):
shopt -s extglob

# In Netbeans don't export the PROMPT_COMMAND variable:
if [ -n "$NBMAGIC" ]; then
	unset PROMPT_COMMAND
fi

# Show the working directory in the prompt:
# If the working directory is a git repo, show the branch or tag:
PROMPT_COMMAND='
	GIT_PROMPT=""
	if git rev-parse --git-dir > /dev/null 2>&1; then
		GIT_PROMPT="($( \
			git symbolic-ref --quiet --short HEAD || \
			git describe --tags 2> /dev/null || \
			printf commit | tr -d \"\n\" \
		)) "
	fi
	PS1="\w $GIT_PROMPT$ "
'

# Activate git bash completion:
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
	source /opt/local/etc/profile.d/bash_completion.sh
fi

# Activate mvn bash completion:
source ~/.mvn-bash-completion/bash_completion.bash

# Bind <Alt-a> and <Alt-s> to history search:
bind '"å": history-search-backward'
bind '"ß": history-search-forward'

export NVM_DIR="/Users/kylestiemann/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Load RVM into a shell session *as a function*

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
