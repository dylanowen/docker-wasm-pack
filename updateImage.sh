#!/usr/bin/env bash
set -eu

BASE_DIR=$(cd $(dirname $0); pwd)

# If this stops working we could maybe use https://forge.rust-lang.org/infra/channel-layout.html
RUST_VERSION=$(docker run --rm rust:latest rustc --version 2>/dev/null | cut -d ' ' -f 2)
>&2 echo "Latest Rust Docker Version: ${RUST_VERSION}"

sed "s/%%RUST_VERSION%%/${RUST_VERSION}/g" ${BASE_DIR}/Dockerfile.template > ${BASE_DIR}/Dockerfile

if [[ `git status --porcelain` ]]; then
  git add -A &> /dev/null
  >&2 echo "Updating to ${RUST_VERSION}"
  echo "true"
else
  >&2 echo "No changes, ${RUST_VERSION} is the latest"
  echo "false"
fi
