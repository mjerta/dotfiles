#!/usr/bin/env bash

# Set defaults
TTL=600
PROXIED=false
COMMENT=Auto-generated

# Define your zone domain if you want fully qualified names (optional)
ZONE_DOMAIN="mpdev.nl"

# Define full path to the script
SCRIPT_PATH="$HOME/my-setup-scripts/scripts/add-new-dns-record.sh"

if [ ! -f "$SCRIPT_PATH" ]; then
  echo "❌ Script not found: $SCRIPT_PATH"
  exit 1
fi


sh $SCRIPT_PATH cms.$ZONE_DOMAIN CNAME mpdev.nl $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH hangman.$ZONE_DOMAIN CNAME mpdev.nl $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH projects.$ZONE_DOMAIN CNAME mpdev.nl $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH postgres.$ZONE_DOMAIN CNAME mpdev.nl $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH wordpress.$ZONE_DOMAIN CNAME mpdev.nl $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH thinkcentre.$ZONE_DOMAIN A 95.99.66.228 $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH tech-it-easy.$ZONE_DOMAIN CNAME mjerta.github.io $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH netlify-test.$ZONE_DOMAIN CNAME net-testing.netlify.app $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH copy-project.$ZONE_DOMAIN CNAME copy-project.netlify.app $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH shopping-list.$ZONE_DOMAIN CNAME mpdev.nl $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH postgres-demo2.$ZONE_DOMAIN CNAME postgres-demo2.onrender.com $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH hotel-california.$ZONE_DOMAIN CNAME production-hotel-california-frontend.netlify.app $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH github-pages-test.$ZONE_DOMAIN CNAME mjerta.github.io $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH wordpress-tpsnederland.$ZONE_DOMAIN A 87.212.40.12 $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH project-manager-backend.$ZONE_DOMAIN CNAME mpdev.nl $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH hotel-california-backend.$ZONE_DOMAIN CNAME production-hotel-california-backend.onrender.com $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH staging-hotel-california.$ZONE_DOMAIN CNAME staging-hotel-california-frontend.netlify.app $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH hotel-california-frontend.$ZONE_DOMAIN CNAME mpdev.nl $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH wordpress-ecriminologyresearch.$ZONE_DOMAIN A 87.212.40.12 $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH project-manager-backend-staging.$ZONE_DOMAIN CNAME mpdev.nl $TTL $PROXIED $COMMENT
sh $SCRIPT_PATH staging-hotel-california-backend.$ZONE_DOMAIN CNAME staging-hotel-california-backend.onrender.com $TTL $PROXIED $COMMENT
