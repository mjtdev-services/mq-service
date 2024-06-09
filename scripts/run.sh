#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "${SCRIPT_DIR}/CONFIG"

ENV_FILE="${SCRIPT_DIR}/../.env"

docker run -it --rm \
  --name "${NAME}" \
  -p 9222:9222 -v "${SCRIPT_DIR}/../nats.conf:/nats.conf" \
  --env-file "${ENV_FILE}"  "${IMAGE_TAG}" \
  -c /nats.conf