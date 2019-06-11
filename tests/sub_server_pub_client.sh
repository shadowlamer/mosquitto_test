#!/bin/bash
echo "Testing normal bridge operation"
start server
start client
subscribe server
publish client local/test test
sleep 1
unsubscribe server
stop client
stop server