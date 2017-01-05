#!/bin/bash

SERVER=$1
USER=$2
DEVICE=$3

if [ -z $SERVER ]; then
    SERVER=127.0.0.1
fi

if [ -z $USER ]; then
    USER=user0
fi

if [ -z $DEVICE ]; then
    DEVICE=eth1
fi

# Firstly, we are going to set up the cascade connection to the server
. bridge-configuration/cascade-connection.sh $SERVER 5555 $USER

# Now we have to configure the bridge between physical and virtual if
. bridge-configuration/create-bridge.sh $SERVER 5555 $DEVICE

echo "The bridge is ready."
