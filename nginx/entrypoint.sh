#!/bin/sh
set -e

envsubst '$UPSTREAM_HOST $LOCAL_NETWORK $CLIENT_NETWORK' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

exec "$@"
