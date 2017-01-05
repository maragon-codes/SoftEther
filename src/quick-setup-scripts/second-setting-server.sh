#!/bin/bash

# First, we have to create two VHubs, "HubA" & "HubB"
vpncmd 127.0.0.1:5555 /SERVER /CMD:HubCreate HubA /PASSWORD: &> /dev/null
vpncmd 127.0.0.1:5555 /SERVER /CMD:HubCreate HubB /PASSWORD: &> /dev/null

echo "Hubs have been created."

# We are going to create some users in both hubs
. server-configuration/create-users.sh 127.0.0.1 HubA
. server-configuration/create-users.sh 127.0.0.1 HubB

# Let's enable and configure DHCP
. server-configuration/enable-dhcp.sh 127.0.0.1 HubA
. server-configuration/enable-dhcp.sh 127.0.0.1 HubB

vpncmd 127.0.0.1:5555 /SERVER /HUB:HubA /CMD:DhcpSet /START:10.0.0.2 /END:10.0.0.254 /MASK:255.255.255.0 /EXPIRE:7200 /GW:none /DNS:none /DNS2:none /DOMAIN:none /LOG:yes &> /dev/null

vpncmd 127.0.0.1:5555 /SERVER /HUB:HubB /CMD:DhcpSet /START:20.0.0.2 /END:20.0.0.254 /MASK:255.255.255.0 /EXPIRE:7200 /GW:none /DNS:none /DNS2:none /DOMAIN:none /LOG:yes &> /dev/null

echo "DHCP enabled and configured for both hubs."

# Now, we will setup the router between both hubs
