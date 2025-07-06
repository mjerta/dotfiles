#!/usr/bin/env bash

URI="mpdev.nl"
USER="root"
PORT=22
TIMEOUT=2

if nc -z -w $TIMEOUT "$URI" $PORT; then
  CONTAINERS=$(ssh -p $PORT "$USER@$URI" \
    'sudo docker ps -a --format "{{.Names}} - {{.Status}}" 2>/dev/null')

  CONTAINERS_JSON=$(echo "$CONTAINERS" | sed ':a;N;$!ba;s/\n/\\n/g')
  echo "{\"text\": \"🟢 mpdev up\", \"tooltip\": \"SSH is reachable\\n$CONTAINERS_JSON\"}"
else
  notify-send "🔴 mpdev" "SSH is unreachable"
  echo '{"text": "🔴 mpdev down", "tooltip": "SSH is unreachable"}'
fi
