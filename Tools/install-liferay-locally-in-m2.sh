cd ~/Portals/liferay.com/liferay-portal-6.2.0-jsf-2.1/tomcat-7.0.42
mvn install:install-file -Dfile=lib/ext/portal-service.jar -DgroupId=com.liferay.portal -DartifactId=portal-service -Dpackaging=jar -DgeneratePom=true -Dversion=6.2.0-ga1
mvn install:install-file -Dfile=webapps/ROOT/WEB-INF/lib/portal-impl.jar -DgroupId=com.liferay.portal -DartifactId=portal-impl -Dpackaging=jar -DgeneratePom=true -Dversion=6.2.0-ga1
mvn install:install-file -Dfile=webapps/ROOT/WEB-INF/lib/util-bridges.jar -DgroupId=com.liferay.portal -DartifactId=util-bridges -Dpackaging=jar -DgeneratePom=true -Dversion=6.2.0-ga1
mvn install:install-file -Dfile=webapps/ROOT/WEB-INF/lib/util-java.jar -DgroupId=com.liferay.portal -DartifactId=util-java -Dpackaging=jar -DgeneratePom=true -Dversion=6.2.0-ga1
mvn install:install-file -Dfile=webapps/ROOT/WEB-INF/lib/util-taglib.jar -DgroupId=com.liferay.portal -DartifactId=util-taglib -Dpackaging=jar -DgeneratePom=true -Dversion=6.2.0-ga1
