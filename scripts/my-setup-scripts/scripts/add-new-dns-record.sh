#!/usr/bin/env bash

usage() {
  cat <<EOF
  Usage: $0 [RECORD_NAME] [RECORD_TYPE] [RECORD_CONTENT] [TTL] [PROXIED] [COMMENT] [ZONE_ID] [API_TOKEN]

  Create a DNS record on Cloudflare via API.

  Arguments:
  RECORD_NAME      DNS record name (e.g., sub.example.com)
  RECORD_TYPE      DNS record type (e.g., A, CNAME, TXT)
  RECORD_CONTENT   DNS record content (e.g., IP address or target)
  TTL              TTL in seconds (2 = automatic)
  PROXIED          true or false - proxied through Cloudflare
  COMMENT          Optional comment
  ZONE_ID          (optional) Cloudflare Zone ID, defaults to \$CLOUDFLARE_ZONE_ID
  API_TOKEN        (optional) Cloudflare API Token, defaults to \$CLOUDFLARE_TOKEN

  If any argument is missing, the script will prompt for it interactively.

  Options:
  -h, --help       Show this help message and exit
EOF
}

# If --help or -h is passed, show usage and exit
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  usage
  exit 0
fi

# Read parameters or prompt if missing
RECORD_NAME=${1:-}
if [ -z "$RECORD_NAME" ]; then
  read -p "Enter DNS record name (e.g. sub.example.com): " RECORD_NAME
fi

RECORD_TYPE=${2:-}
if [ -z "$RECORD_TYPE" ]; then
  read -p "Enter DNS record type (e.g. A, CNAME, TXT): " RECORD_TYPE
fi

RECORD_CONTENT=${3:-}
if [ -z "$RECORD_CONTENT" ]; then
  read -p "Enter DNS content (e.g. IP address or target): " RECORD_CONTENT
fi

RECORD_TTL=${4:-}
if [ -z "$RECORD_TTL" ]; then
  read -p "Enter TTL (e.g. 2 for automatic, or 300, 3600): " RECORD_TTL
fi

RECORD_PROXIED=${5:-}
if [ -z "$RECORD_PROXIED" ]; then
  read -p "Should it be proxied through Cloudflare? (true/false): " RECORD_PROXIED
fi

RECORD_COMMENT=${6:-}
if [ -z "$RECORD_COMMENT" ]; then
  read -p "Optional comment: " RECORD_COMMENT
fi
RECORD_COMMENT=${RECORD_COMMENT:-""}

# Zone and Token (args or env vars, else prompt)
set -x
ZONE_ID=${7:-}
if [ -z "$ZONE_ID" ]; then
  read -p "Enter Cloudflare Zone ID: " ZONE_ID
fi

API_TOKEN=${8:-}
if [ -z "$API_TOKEN" ]; then
  read -p "Enter Cloudflare API Token: " API_TOKEN
fi
set +x
# Validate required values
if [[ -z "$ZONE_ID" || -z "$API_TOKEN" ]]; then
  if [[ -z "$CLOUDFLARE_ZONE_ID" && -z "$CLOUDFLARE_TOKEN" ]]; then
    echo "Error: Zone ID and API Token must be provided (either as last arguments or environment variables)."
    exit 2
  else
    ZONE_ID=$CLOUDFLARE_ZONE_ID
    API_TOKEN=$CLOUDFLARE_TOKEN
  fi
fi

# Make the API call
curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
  -H "Authorization: Bearer $API_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"type\": \"$RECORD_TYPE\",
    \"name\": \"$RECORD_NAME\",
    \"content\": \"$RECORD_CONTENT\",
    \"ttl\": $RECORD_TTL,
    \"proxied\": $RECORD_PROXIED,
    \"comment\": \"$RECORD_COMMENT\"
  }" | jq
