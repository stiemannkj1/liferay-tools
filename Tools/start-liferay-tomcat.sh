#!/bin/sh

cd /Users/kylestiemann/Portals/liferay.com/liferay-portal-6.2.1-jsf-2.2/tomcat-7.0.42/bin
./jrebel-catalina.sh $1
tail -f /Users/kylestiemann/Portals/liferay.com/liferay-portal-6.2.1-jsf-2.2/tomcat-7.0.42/logs/catalina.out
