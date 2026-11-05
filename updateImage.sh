#!/usr/bin/env bash
set -euo pipefail

# Moves the Dockerfile to the next Rust release that has a published image, printing that version.
# Stepping one release at a time means every version gets its own PR, tag and release.

BASE_DIR=$(cd "$(dirname "$0")"; pwd)
CURRENT=$(sed -nE '1s/^FROM rust:(.*)$/\1/p' "${BASE_DIR}/Dockerfile")
>&2 echo "Current Rust Version: ${CURRENT}"

newer_versions() {
  { echo "${CURRENT}"; git ls-remote --tags --refs https://github.com/rust-lang/rust | sed -nE 's|.*refs/tags/([0-9]+\.[0-9]+\.[0-9]+)$|\1|p'; } \
    | sort -uV \
    | awk -v current="${CURRENT}" 'seen; $0 == current { seen = 1 }'
}

for VERSION in $(newer_versions); do
  if docker manifest inspect "rust:${VERSION}" > /dev/null 2>&1; then
    sed "s/%%RUST_VERSION%%/${VERSION}/g" "${BASE_DIR}/Dockerfile.template" > "${BASE_DIR}/Dockerfile"
    >&2 echo "Updating to ${VERSION}"
    echo "${VERSION}"
    exit 0
  fi
done

>&2 echo "No newer Rust image than ${CURRENT}"
