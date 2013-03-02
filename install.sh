#!/bin/sh

set -e

if [ -z "${PREFIX}" ]; then
  PREFIX="/usr/local"
fi

BIN_PATH="${PREFIX}/bin"
SHARE_PATH="${PREFIX}/share/lua-build"

mkdir -p "${BIN_PATH}"
mkdir -p "${SHARE_PATH}"

for file in bin/*; do
  cp "${file}" "${BIN_PATH}"
done

for file in share/lua-build/*; do
  cp "${file}" "${SHARE_PATH}"
done

echo "Installed lua-build at ${PREFIX}"
