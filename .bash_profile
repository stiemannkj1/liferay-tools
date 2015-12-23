# Enviornment Variables:
export JAVA_HOME=$(/usr/libexec/java_home)
export MAVEN_OPTS="-Xmx1024m -Djava.awt.headless=true"
export ANT_OPTS="$MAVEN_OPTS -XX:MaxPermSize=256m"
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
export EDITOR="/opt/local/bin/nano"
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
~/Tools/freemarker-generator/bin:\
~/Tools/jalopy/bin:\
~/Tools/vdldoc/bin:\
~/Projects/liferay.com/liferay-faces-maven:\

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

# Add rec_rep function for recursive replacing of (potentially) multiline strings:
function rec_rep() {
	FILES=$(ag --files-with-matches "$1")
	if [[ "$FILES" ]]; then
		SEARCH="${1//,/\\,}"
		REPLACE="${2//,/\\,}"
		perl -0p -i -e "s,$SEARCH,$REPLACE,g" $FILES
		echo "$FILES"
	fi
}

# Add rec_rep_literal function for recursive replacing of (potentially) multiline string literals:
function rec_rep_literal() {
	FILES=$(ag --files-with-matches --literal "$1")
	if [[ "$FILES" ]]; then
		SEARCH="${1//,/\\,}"
		REPLACE="${2//,/\\,}"
		perl -0p -i -e "s,\Q$SEARCH,$REPLACE,g" $FILES
		echo "$FILES"
	fi
}

# Activate mvn bash completion:
source ~/.mvn-bash-completion/bash_completion.bash

# Bind <Alt-a> and <Alt-s> to history search:
bind '"å": history-search-backward'
bind '"ß": history-search-forward'

export NVM_DIR="/Users/kylestiemann/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
