#!/usr/bin/env bash
set -eu

BASE_DIR=$(cd $(dirname $0); pwd)

# If this stops working we could maybe use https://forge.rust-lang.org/infra/channel-layout.html
RUST_VERSION=$(rustc --version | cut -d ' ' -f 2)

sed "s/%%RUST_VERSION%%/${RUST_VERSION}/g" ${BASE_DIR}/Dockerfile.template > ${BASE_DIR}/Dockerfile

if [[ `git status --porcelain` ]]; then
  git add -A &> /dev/null
  echo "true"
else
  echo "false"
fi
