#!/bin/bash

export MYSQL_HOME=/home/kylestiemann/Databases/mysql-5.7.23-linux-glibc2.12-x86_64 &&
source my.ini &&
rm -r $DATADIR/*
mysqld \
	--datadir=$DATADIR \
	--basedir=$MYSQL_HOME \
	--log-error=$MYSQL_HOME/log/mysql.err \
	--pid-file=$MYSQL_HOME/mysql.pid \
	--socket=/tmp/mysql.sock \
	--port=3306 \
	--initialize \
	--skip-networking \
	--initialize-insecure
