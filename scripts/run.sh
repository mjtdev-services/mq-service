#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "${SCRIPT_DIR}/CONFIG"

ENV_FILE="${SCRIPT_DIR}/../.env"

docker run -it --rm \
  --name "${NAME}" \
  -p 5901:5901 \
  -v "${SCRIPT_DIR}/${DATA_DIR}:/home/user/Monero/wallets/our-wallet:rw" \
  --env-file "${ENV_FILE}"  "${IMAGE_TAG}"