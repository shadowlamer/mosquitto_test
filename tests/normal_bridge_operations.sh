#!/bin/bash
echo "Testing normal bridge operation"
start server
start client
subscribe server
subscribe client
publish server toclient/test msg_to_client
sleep 0.5
publish client local/test msg_to_server
sleep 0.5
unsubscribe server
unsubscribe client
stop client
stop server