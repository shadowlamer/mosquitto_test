#!/bin/bash
echo "Testing server starts after publishing to client"
start client
subscribe client
publish client local/test msg_to_server
start server
subscribe server
publish server toclient/test msg_to_client
sleep 10
unsubscribe server
unsubscribe client
stop client
stop server