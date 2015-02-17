# This file is symlinked in every portal/tomcat/bin folder using the following command:
# for folder in $(find . -name "tomcat-*" -type d); do (cd $folder/bin/ && ln -s /Users/kylestiemann/Portals/liferay.com/properties/setenv.sh setenv.sh); done
JAVA_OPTS="$JAVA_OPTS -javaagent:/Users/kylestiemann/.jrebel/jrebel.jar -Dfile.encoding=UTF8 -Djava.net.preferIPv4Stack=true  -Dorg.apache.catalina.loader.WebappClassLoader.ENABLE_CLEAR_REFERENCES=false -Duser.timezone=GMT -Xmx2048m -XX:MaxPermSize=512m"
