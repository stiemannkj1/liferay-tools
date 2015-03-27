# Enviornment Variables:
export JAVA_HOME=$(/usr/libexec/java_home)
export MAVEN_OPTS="-Xmx1024m -Djava.awt.headless=true"
export ANT_OPTS=$MAVEN_OPTS
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Make mvim -v the default terminal editor:
export EDITOR="/opt/local/bin/mvim -v"
export VISUAL="$EDITOR"

# Add micro command to run mvim -v:
alias micro="$EDITOR"

# Alias vim to have default settings:
alias vim='/usr/bin/vim -u NONE'

# Path
# /opt/local/bin:\ is first because macports needs to be first on the list.
export PATH=\
/opt/local/bin:\
/bin:\
/opt/local/sbin:\
/sbin:\
/usr/bin:\
/usr/sbin:\
/usr/local/bin:\
/usr/local/mysql/bin:\
$JAVA_HOME/bin:\
/Applications/NetBeans/NetBeans\ 8.0.app/Contents/Resources/NetBeans/java/maven/bin:\
~/Tools:\
~/Tools/freemarker-generator/bin:\
~/Tools/jalopy/bin:\
~/Tools/vdldoc/bin:\
~/Tools/my-tools:\
~/Projects/liferay.com/faces/master:\

# Support wildcards (*):
shopt -s globstar
# Support inverse wildcards (!):
shopt -s extglob

# Add growl command to alert me when processes complete:
alias growl='/usr/bin/osascript -e "display notification with title \"Process Completed.\""'

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

# Colored git prompt (SLOW):
#PROMPT_COMMAND='
#    GIT_PROMPT=""
#    if git rev-parse --git-dir > /dev/null 2>&1; then
#       COLOR=""
#       if ! git diff-files --quiet --ignore-submodules --; then
#           COLOR="\e[0;31m"
#       elif ! git diff-index --cached --quiet HEAD --ignore-submodules --; then
#           COLOR="\e[0;32m"
#       fi
#       GIT_PROMPT="($COLOR$(git symbolic-ref --quiet --short HEAD || git describe --tags | tr -d '\n')\e[0m) "
#    PS1="\w $GIT_PROMPT$ "
#'

# Activate git bash completion:
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
	source /opt/local/etc/profile.d/bash_completion.sh
fi

# Add git_sed function:
function git_sed() {
	FILES=$(git grep --files-with-matches --name-only "$1")
	if [[ "$FILES" ]]; then
		SEARCH="${1/,/\\,}"
		REPLACE="${2/,/\\,}"
		gsed -i -e "s,$SEARCH,$REPLACE,g" $FILES
		echo "$FILES"
	fi
}

# Add rec_rep function for recursive replacing of (potentially) multiline strings:
function rec_rep() {
	FILES=$(ag --files-with-matches "$1")
	if [[ "$FILES" ]]; then
		SEARCH="${1/,/\\,}"
		REPLACE="${2/,/\\,}"
		perl -0p -i -e "s,$SEARCH,$REPLACE,g" $FILES
		echo "$FILES"
	fi
}

# Activate mvn bash completion:
source ~/.mvn-bash-completion/bash_completion.bash

# Start the Netbeans terminal in the $HOME directory:
if [ -n "$NBMAGIC" ]; then
	cd ~/
fi

# Bind <C-Up> and <C-Down> to history search:
bind '"\e[1;5A": history-search-backward'
bind '"\e[1;5B": history-search-forward'

