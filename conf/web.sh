#!/bin/bash

SERVER_IP="127.0.0.1" 
PORT=80               
FILE="/var/www/html/index.html"

if ! nc -z "$SERVER_IP" "$PORT"; then
   echo "Port close"
   exit 1
fi

if [[ ! -f "$FILE" ]]; then
   echo "file not found"
   exit 1
fi

exit 0