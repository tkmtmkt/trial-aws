#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
set -o verbose

cd ${BASE_DIR}
docker run --rm -it \
  --env-file=${BASE_DIR}/.env \
  -w /root \
  -v "${BASE_DIR}:/root" \
  -v ~/.aws:/root/.aws \
  hashicorp/terraform $@
