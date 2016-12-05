#!/bin/bash
set -x
# Invoke the UCD REST interface to import the version created in the Bluemix Container Registry.
# Then verify the version was imported or time-out.

# Get command-line parameters
COMPONENT=$1
VERSION=$2
PASSWORD=$3

# Import a new component version into UCD using a REST call. This call is asynchronous and will return before
# the UCD version import process completes
curl -k -u admin:$PASSWORD https://10.173.188.45:8443/cli/component/integrate -X PUT -d {"component":"$COMPONENT"}
sleep 20

# Check to see if the version was created. If this doesn't happen within a minute return failure.
ATTEMPTS=0
while [ $ATTEMPTS -lt 6 ]; do
        CRESULT=`udclient getVersionProperties -component $COMPONENT -version $VERSION 2>&1`
        if [[ $CRESULT =~ "could not be resolved" ]]; then
                let ATTEMPTS=ATTEMPTS+1
                echo "Attempt $ATTEMPTS of 6"
                sleep 10
        else
                echo "Version $VERSION of component $COMPONENT has been created."
                exit 0
        fi
done

echo "Failed find Version $VERSION of component $COMPONENT."
exit 1
