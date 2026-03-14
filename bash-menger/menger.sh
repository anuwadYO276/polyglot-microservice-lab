#!/bin/bash

PORT=8090

echo "Bash server running on port $PORT"

while true
do
    {
        read request

        echo "Connection received"

        JSON='{
"bash-menger":{
"package_manager":"bash script",
"dependency_file":"N/A",
"source_code":"menger.sh",
"runtime":"Bash shell"
}
}'

        echo -e "HTTP/1.1 200 OK\r"
        echo -e "Content-Type: application/json\r"
        echo -e "Content-Length: ${#JSON}\r"
        echo -e "\r"
        echo -e "$JSON"
    } | nc -l -p $PORT
done