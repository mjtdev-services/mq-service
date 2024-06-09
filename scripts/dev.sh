#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "${SCRIPT_DIR}/CONFIG"

ENV_FILE="${SCRIPT_DIR}/../.env"

  # -v "$(pwd)/${CONFIG_FILE}:/app/vendor/xmrig/build/config.json:ro" \
docker run -it --rm \
  --name "${NAME}" \
  --env-file "${ENV_FILE}" \
  -p 5900:5900 -p 5901:5901 \
  -v "${SCRIPT_DIR}/${DATA_DIR}:/data:rw" \
  --entrypoint /bin/bash  "${IMAGE_TAG}"