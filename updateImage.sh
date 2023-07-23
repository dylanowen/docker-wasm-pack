#!/usr/bin/env bash
set -eu

BASE_DIR=$(cd $(dirname $0); pwd)



RUST_VERSION=${1}

sed "s/%%RUST_VERSION%%/${RUST_VERSION}/g" ${BASE_DIR}/Dockerfile.template > ${BASE_DIR}/Dockerfile
