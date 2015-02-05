# Enviornment Variables
export JAVA_HOME=`/usr/libexec/java_home`
export HOME=/Users/kylestiemann
export PORTALS_HOME=$HOME/Portals
export PROJECTS_HOME=$HOME/Projects

# Script Varibles
TOOLS=$HOME/Tools

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
$TOOLS:\
$TOOLS/freemarker-generator/bin:\
$TOOLS/jalopy/bin:\
$TOOLS/vdldoc/bin:\
$TOOLS/my-tools:\
$PROJECTS_HOME/liferay.com/faces/master:\
$HOME/.rvm/bin

# Support zsh-like wildcards:
shopt -s globstar

# Make nano the default terminal editor:
export EDITOR="/opt/local/bin/nano"
export VISUAL="$EDITOR"

# Add growl command to alert me when processes complete:
alias growl='osascript -e "display notification with title \"Process Completed.\""'

# Show the working directory in the prompt:
# If the working directory is a git repo, show the branch or tag:
PROMPT_COMMAND='
	GIT_PROMPT=""
	if git rev-parse --git-dir > /dev/null 2>&1; then
		GIT_PROMPT="($(git symbolic-ref --quiet --short HEAD || git describe --tags | tr -d '\n')) "
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
source $HOME/git-completion/git-completion.sh

# Add git_sed function:
function git_sed() {
	FILES=$(git grep --full-name --name-only "$1")
	if [[ "$FILES" ]]; then
		SEARCH="${1/,/\\,}"
		REPLACE="${2/,/\\,}"
		gsed -i -e "s,$SEARCH,$REPLACE,g" $FILES
		echo "$FILES"
	fi
}

# Export environment variables for maven:
export MAVEN_OPTS="-Xms256m -Xmx1024m -XX:MaxPermSize=128m -Djava.awt.headless=true"

# Export environment variables for ant:
export ANT_OPTS="-Xmx1024m -XX:MaxPermSize=512m -Djava.awt.headless=true"

# Export enviornment variables to support Mercurial:
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
