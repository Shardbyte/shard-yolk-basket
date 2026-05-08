#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

fail() {
  printf 'error: %s\n' "$1" >&2
  exit 1
}

cd "${ROOT_DIR}"

if grep -RInE --include='Dockerfile' 'apt(-get)?[[:space:]]+(dist-)?upgrade' .; then
  fail "Dockerfiles must not run apt upgrade or dist-upgrade."
fi

if grep -RInE --include='Dockerfile' 'archive\.ubuntu\.com|ports\.ubuntu\.com|dpkg[[:space:]]+-i' .; then
  fail "Manual Ubuntu archive .deb installs must stay out of modern images."
fi

if grep -RInE --include='Dockerfile' 'apt(-get)?[[:space:]]+install' . | grep -v -- '--no-install-recommends'; then
  fail "apt installs should use --no-install-recommends."
fi

printf 'Repository policy checks passed.\n'
