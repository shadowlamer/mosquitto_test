#!/bin/bash

HOMEDIR=$(pwd)

. functions.sh

#Start proxy DNS
DNSID=$(docker run -d --rm --hostname dns.mageddo -v /var/run/docker.sock:/var/run/docker.sock -v /etc/resolv.conf:/etc/resolv.conf defreitas/dns-proxy-server)
sleep 1

for TEST in ${HOMEDIR}/tests/*.sh; do 
. ${TEST}
done

#Stop proxy DNS
docker stop ${DNSID} > /dev/null
