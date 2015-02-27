# This file is symlinked in every portal/ folder using the following command:
# for folder in [0-9].[0-9]?(-ee); do (cd $folder/tomcat-*/bin && ln -s /Users/kylestiemann/Portals/liferay.com/properties/setenv.sh setenv.sh); done
JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF8 -Djava.net.preferIPv4Stack=true  -Dorg.apache.catalina.loader.WebappClassLoader.ENABLE_CLEAR_REFERENCES=false -Duser.timezone=GMT -Xmx2048m -XX:MaxPermSize=512m -Djava.awt.headless=true"
