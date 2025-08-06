#!/usr/bin/env bash

usage() {
  cat << EOF
Usage: $0 [RECORD_NAME] [RECORD_TYPE] [RECORD_CONTENT] [TTL] [PROXIED] [COMMENT]

Create a DNS record on Cloudflare via API.

Arguments:
  RECORD_NAME      DNS record name (e.g., sub.example.com)
  RECORD_TYPE      DNS record type (e.g., A, CNAME, TXT)
  RECORD_CONTENT   DNS record content (e.g., IP address or target)
  TTL              TTL in seconds (1 = automatic)
  PROXIED          true or false - proxied through Cloudflare
  COMMENT          Optional comment

If any argument is missing, the script will prompt for it interactively.

Environment variables CLOUDFLARE_ZONE_ID and CLOUDFLARE_TOKEN must be set.

Options:
  -h, --help       Show this help message and exit

Example:
  $0 sub.example.com A 1.2.3.4 300 true "Auto-created record"
EOF
}

set -x

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
  read -p "Enter TTL (e.g. 1 for automatic, or 300, 3600): " RECORD_TTL
fi

RECORD_PROXIED=${5:-}
if [ -z "$RECORD_PROXIED" ]; then
  read -p "Should it be proxied through Cloudflare? (true/false): " RECORD_PROXIED
fi

RECORD_COMMENT=${6:-}
if [ -z "$RECORD_COMMENT" ]; then
  read -p "Optional comment: " RECORD_COMMENT
fi

# Default empty comment if none provided
RECORD_COMMENT=${RECORD_COMMENT:-""}

# Validate required env vars
if [[ -z "$CLOUDFLARE_ZONE_ID" || -z "$CLOUDFLARE_TOKEN" ]]; then
  echo "Error: CLOUDFLARE_ZONE_ID and CLOUDFLARE_TOKEN environment variables must be set." >&2
  exit 1
fi

# Make the API call
curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE_ID/dns_records" \
    -H "Authorization: Bearer $CLOUDFLARE_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{
          \"type\": \"$RECORD_TYPE\",
          \"name\": \"$RECORD_NAME\",
          \"content\": \"$RECORD_CONTENT\",
          \"ttl\": $RECORD_TTL,
          \"proxied\": $RECORD_PROXIED,
          \"comment\": \"$RECORD_COMMENT\"
        }" | jq
