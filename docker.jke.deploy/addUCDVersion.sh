#!/bin/bash

# Simple shell script to test if a site is up

COMPONENT=$1
VERSION=$2
ATTEMPTS=0
while [  $ATTEMPTS -lt 6 ]; do
	CRESULT=`udclient getVersionProperties -component $COMPONENT -version $VERSION`
	echo "$CRESULT"
	if [[ $CRESULT =~ "could not be resolved" ]]; then
		let ATTEMPTS=ATTEMPTS+1
		echo "Attempt $ATTEMPTS of 6"
		sleep 20
	else
		echo "Version $VERSION of component $COMPONENT has been created."
		exit 0
	fi
done
echo "Failed find Version $VERSION of component $COMPONENT."
exit 1
