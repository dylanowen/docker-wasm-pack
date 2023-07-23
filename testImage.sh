#!/usr/bin/env bash
set -eu

BASE_DIR=$(cd $(dirname $0); pwd)

IMAGE_TAG=${1}

TEST_SCRIPT=$(cat <<END
# Make sure we don't need extra binaries
echo "127.0.0.1   github.com" >> /etc/hosts ;
echo "127.0.0.1   rust-lang.org" >> /etc/hosts ;
echo "127.0.0.1   static.rust-lang.org" >> /etc/hosts ;

# build our test project
wasm-pack build

END)

docker run \
  --rm \
  -v ${BASE_DIR}/test:/usr/src/test \
  --workdir /usr/src/test \
  ${IMAGE_TAG} \
  /bin/bash -c "${TEST_SCRIPT}"
