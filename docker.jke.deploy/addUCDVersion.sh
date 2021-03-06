#!/bin/bash

# Invoke the UCD REST interface to import the version created in the Bluemix Container Registry.
# Then verify the version was imported or time-out.

# Get command-line parameters
COMPONENT=$1
VERSION=$2
UCD_URL=$3
UCD_USERNAME=$4
UCD_PASSWORD=$5
echo "Importing version $VERSION of $COMPONENT component."

# Setup environment to run udclient
export JAVA_HOME=/etc/alternatives/jre_1.8.0_openjdk
export DS_USERNAME=$UCD_USERNAME
export DS_PASSWORD=$UCD_PASSWORD
export DS_WEB_URL=$UCD_URL

# Import a new component version into UCD using a REST call. This call is asynchronous and will return before
# the UCD version import process completes
curl -k -u $DS_USERNAME:$DS_PASSWORD ${DS_WEB_URL}/cli/component/integrate -X PUT -d {"component":"$COMPONENT"}

# Check to see if the version was created. If this doesn't happen within a minute return failure.
ATTEMPTS=0
while [ $ATTEMPTS -lt 6 ]; do
        CRESULT=`/opt/ibm-ucd/udclient/udclient getVersionProperties -component $COMPONENT -version $VERSION 2>&1`
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
