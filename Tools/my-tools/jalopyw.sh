#!/opt/local/bin/bash

case "$PWD" in
	*liferay-faces-bridge-impl*|\
		*liferay-faces-bridge-api*|\
		*liferay-faces-showcase*|\
		*liferay-faces-test-selenium*|\
		*liferay-faces-util*)
		PROFILE_ARG="--profile=liferay-faces-apache-2.0"
	;;
	*)
		PROFILE_ARG="--profile=liferay-faces"
	;;
esac

~/Tools/jalopy-1.9.5/bin/jalopy.sh $PROFILE_ARG "$@"
