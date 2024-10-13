#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "${SCRIPT_DIR}/CONFIG"

ENV_FILE="${SCRIPT_DIR}/../.env"

# Load the environment variables from the .env file
set -o allexport
source "${ENV_FILE}"
set +o allexport

docker network create "${NETWORK_NAME}" || true

docker stop "${NAME}" || true
#-p 9222:9222 \
docker run -it --rm -d \
  --name "${NAME}" \
  --network mq_network \
  -v "${SCRIPT_DIR}/../nats.conf:/nats.conf" \
  --env-file "${ENV_FILE}" \
   "${IMAGE_TAG}" \
  -c /nats.conf

docker stop cloudflared || true
docker run --rm -d \
  --name cloudflared \
  --network mq_network \
  cloudflare/cloudflared:latest tunnel \
  --no-autoupdate run \
  --token "${CF_TUNNEL}" \
