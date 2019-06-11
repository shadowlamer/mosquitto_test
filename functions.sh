#!/bin/bash

declare -A MOSQUITTOS
declare -A SUBSCRIPTIONS

function start() {
CLIENTID="$1"
echo "Starting ${CLIENTID}"
MOSQUITTOS[${CLIENTID}]=$(docker run -d --rm \
--hostname ${CLIENTID}.mosquitto \
-v ${HOMEDIR}/conf/${CLIENTID}/config:/mosquitto/config \
-v ${HOMEDIR}/conf/${CLIENTID}/log:/mosquitto/log \
-v ${HOMEDIR}/conf/${CLIENTID}/data:/mosquitto/data \
eclipse-mosquitto)
sleep 1
}

function stop() {
CLIENTID="$1"
echo "Stopping ${CLIENTID}"
docker stop ${MOSQUITTOS[${CLIENTID}]} > /dev/null
}

function publish() {
CLIENTID="$1"
TOPIC="$2"
MESSAGE="$3"
echo "Publishing \"${MESSAGE}\" to ${TOPIC} on ${CLIENTID}"
mosquitto_pub -h ${CLIENTID}.mosquitto -t ${TOPIC} -m ${MESSAGE}
}

function subscribe() {
CLIENTID="$1"
echo "Subscribing to ${CLIENTID}"
mosquitto_sub -h ${CLIENTID}.mosquitto -v -t "#" | while read TOPIC MESSAGE; do echo "Read from ${TOPIC} on ${CLIENTID}: ${MESSAGE}"; done &
SUBSCRIPTIONS[${CLIENTID}]=$!
sleep 1
}

function unsubscribe() {
CLIENTID="$1"
echo "Unsubscribing from ${CLIENTID}"
kill ${SUBSCRIPTIONS[${CLIENTID}]}
}