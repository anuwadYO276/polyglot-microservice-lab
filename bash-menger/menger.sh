#!/usr/bin/env bash

PORT=8090

echo "Bash server running on port $PORT"

while true; do
  {
    echo -ne "HTTP/1.1 200 OK\r\n"
    echo -ne "Content-Type: application/json\r\n"
    echo -ne "Connection: close\r\n"
    echo -ne "\r\n"
    echo '{"bash-menger":{"package_manager":"bash script","dependency_file":"N/A","source_code":"menger.sh","runtime":"Bash shell"}}'
  } | nc -l -p $PORT
done