#!/usr/bin/env bash
set -Eeuo pipefail

cd /home/container

INTERNAL_IP="$(ip route get 1 2>/dev/null | awk '{print $(NF-2); exit}')"
export INTERNAL_IP

if [[ -z "${STARTUP:-}" ]]; then
  echo "STARTUP is not set; nothing to run." >&2
  exit 1
fi

MODIFIED_STARTUP="$(printf '%s' "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')"

printf ':/home/container$ %s\n' "${MODIFIED_STARTUP}"
exec bash -lc "${MODIFIED_STARTUP}"
