#!/usr/bin/env bash

PORT=8090

# ===== LOG FUNCTION =====
write_log() {
  TODAY=$(date +%Y%m%d)
  LOG_DIR="/logs/$TODAY"

  mkdir -p "$LOG_DIR"

  TIMESTAMP=$(date --iso-8601=seconds 2>/dev/null || date "+%Y-%m-%dT%H:%M:%S")
  echo "[$TIMESTAMP] $1" >> "$LOG_DIR/log.txt"
}

echo "Bash server running on port $PORT"
write_log "Bash server started on port $PORT"

while true; do
  {
    # อ่าน request (บรรทัดแรก)
    read REQUEST_LINE

    write_log "Request: $REQUEST_LINE"

    echo -ne "HTTP/1.1 200 OK\r\n"
    echo -ne "Content-Type: application/json\r\n"
    echo -ne "Connection: close\r\n"
    echo -ne "\r\n"
    echo '{"bash-menger":{"package_manager":"bash script","dependency_file":"N/A","source_code":"menger.sh","runtime":"Bash shell"}}'

    write_log "Response sent"
  } | nc -l -p $PORT
done