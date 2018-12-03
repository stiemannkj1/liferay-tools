#!/bin/bash

trap 'killall mysqld; exit' SIGHUP SIGTERM SIGINT SIGQUIT
export MYSQL_HOME=/home/kylestiemann/Databases/mysql-5.7.23-linux-glibc2.12-x86_64 &&
source my.ini &&
mysqld \
	--datadir=$DATADIR \
	--basedir=$MYSQL_HOME \
	--log-error=$MYSQL_HOME/log/mysql.err \
	--pid-file=$MYSQL_HOME/mysql.pid \
	--socket=/tmp/mysql.sock \
	--port=3306 &
sleep 5
mysql -u root -e 'show databases;' | grep -q lportal ||
	echo 'Setting up Liferay Database' &&
	mysql -u root < /home/kylestiemann/Projects/liferay.com/liferay-portal/sql/create/create-mysql.sql
echo "Stop MySQL with Ctrl + C"
while true; do :; done
