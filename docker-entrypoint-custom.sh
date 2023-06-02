#!/usr/bin/env bash
# Author: Abhijit Wakchaure <awakchau@tibco.com>

# arg1: error message
# [arg2]: exit code
function exit_with_error {
    printf '\n%s\n' "$1" >&2 ## Send message to stderr.
    exit "${2-1}" ## Return a code specified by $2, or 1 by default.
}

# Run the script to generate SSL certs on the fly
${CERTS_ROOT}/createCerts.sh

python3 -m http.server -d ${CERTS_ROOT}/certs &

exec /docker-entrypoint.sh /usr/sbin/mosquitto -c /mosquitto/config/mosquitto.conf
