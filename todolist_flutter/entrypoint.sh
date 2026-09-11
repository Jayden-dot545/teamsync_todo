#!/bin/sh
set -e

# If API_URL is provided in container environment, inject into assets/config.json
if [ -n "$API_URL" ]; then
  echo "{\"apiUrl\": \"$API_URL\"}" > /usr/share/nginx/html/assets/config.json 2>/dev/null || true
  echo "{\"apiUrl\": \"$API_URL\"}" > /usr/share/nginx/html/assets/assets/config.json 2>/dev/null || true
  echo "Configured Flutter Web API_URL to: $API_URL"
fi

exec nginx -g "daemon off;"
