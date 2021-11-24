#!/bin/bash

set -eo pipefail

# A script for update webhook
#
# With The ngrok free plan, the URL cannot be fixed and changes every time.
# This script gets the ngrok public_url and sets it to GitHub Webhook via API.
#
# Environment Variables
# DEV_REPO: A repository to be updated webhook (eg. minamijoyo/atlantis-dev)
# ADMIN_GH_TOKEN: A GitHub Token (admin:repo_hook scope) for update webhoook

# wait for listen
dockerize -wait http://ngrok:4040 -timeout 30s

# Get ngrok public_url
# https://ngrok.com/docs#inspect-status
PUBLIC_URL=$(curl -sS ngrok:4040/api/tunnels | jq -r '.tunnels[] | select(.public_url | startswith("https")) | .public_url')

echo "PUBLIC_URL: $PUBLIC_URL"

# Find WebHook Configuration
# https://docs.github.com/en/rest/reference/repos#list-repository-webhooks
HOOK_ID=$(curl -sS \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token ${ADMIN_GH_TOKEN}" \
  "https://api.github.com/repos/${DEV_REPO}/hooks" \
 | jq -r '.[] | select(.config.url | contains("ngrok.io")) | .id')

echo "PUBLIC_URL: $HOOK_ID"

WEBHOOK_URL="$PUBLIC_URL/events"

# Update WebHook
# https://docs.github.com/en/rest/reference/repos#update-a-webhook-configuration-for-a-repository
jq -n --arg url "$WEBHOOK_URL" '{url: $url}' \
  | curl -sS \
      -X PATCH \
      -H "Accept: application/vnd.github.v3+json" \
      -H "Authorization: token ${ADMIN_GH_TOKEN}" \
      -d@- \
      "https://api.github.com/repos/${DEV_REPO}/hooks/${HOOK_ID}/config"

echo "updated webhoook"
