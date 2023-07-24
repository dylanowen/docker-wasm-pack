#!/usr/bin/env bash
set -eu

VERSION_TAG=$(head -1 Dockerfile | cut -d ':' -f 2)
>&2 echo "Current Version: ${VERSION_TAG}"

if git rev-parse "${VERSION_TAG}" >/dev/null 2>&1; then
  >&2 echo "The Tag: ${VERSION_TAG} already exists"
  echo "false"
else
  git tag ${VERSION_TAG} &> /dev/null
  git push origin --tag
  >&2 echo "Created Tag: ${VERSION_TAG}"
  echo "true"
fi
