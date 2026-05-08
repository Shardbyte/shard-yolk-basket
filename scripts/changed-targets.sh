#!/usr/bin/env bash
set -Eeuo pipefail

BASE_SHA="${1:-}"
HEAD_SHA="${2:-HEAD}"
EVENT_NAME="${3:-}"

ALL_TARGETS=(
  oses-debian
  base-runtime
  base-build
  oses-ubuntu
  oses-alpine
  java-17
  java-21
  java-25
  nodejs-20
  nodejs-22
  nodejs-24
  nodejs-20-build
  python-3-13
  dotnet-9
  dotnet-10
  go-1-24
  wine-10
  games-generic
  games-source
  games-unity
  steamcmd-debian
  installers-debian
  installers-java-21
  installers-dotnet-10
)

declare -A SELECTED=()

add_target() {
  SELECTED["$1"]=1
}

add_all() {
  local target
  for target in "${ALL_TARGETS[@]}"; do
    add_target "${target}"
  done
}

add_build_targets() {
  add_target base-build
  add_target dotnet-9
  add_target dotnet-10
  add_target nodejs-20-build
  add_target go-1-24
}

add_games_dependents() {
  add_target games-source
  add_target games-unity
  add_target python-3-13
  add_target wine-10
}

add_runtime_targets() {
  add_target base-runtime
  add_target games-generic
  add_games_dependents
}

json_array() {
  local first=1
  local target

  printf '['
  for target in "${ALL_TARGETS[@]}"; do
    if [[ -n "${SELECTED[${target}]:-}" ]]; then
      if (( first )); then
        first=0
      else
        printf ','
      fi
      printf '"%s"' "${target}"
    fi
  done
  printf ']'
}

if [[ "${EVENT_NAME}" == "workflow_dispatch" ]]; then
  add_all
elif [[ -z "${BASE_SHA}" || "${BASE_SHA}" =~ ^0+$ ]]; then
  add_all
elif ! git merge-base --is-ancestor "${BASE_SHA}" "${HEAD_SHA}" >/dev/null 2>&1; then
  add_all
else
  while IFS= read -r path; do
    case "${path}" in
      .dockerignore|build/docker-bake.hcl|.github/workflows/ci.yml|.github/workflows/publish.yml)
        add_all
        ;;
      oses/debian/*)
        add_all
        ;;
      base/runtime/*)
        add_runtime_targets
        ;;
      base/build/*)
        add_build_targets
        ;;
      oses/ubuntu/*)
        add_target oses-ubuntu
        ;;
      oses/alpine/*)
        add_target oses-alpine
        ;;
      java/17/*)
        add_target java-17
        ;;
      java/21/*)
        add_target java-21
        ;;
      java/25/*)
        add_target java-25
        ;;
      nodejs/20/*)
        add_target nodejs-20
        ;;
      nodejs/22/*)
        add_target nodejs-22
        ;;
      nodejs/24/*)
        add_target nodejs-24
        ;;
      nodejs/20-build/*)
        add_target nodejs-20-build
        ;;
      python/3.13/*)
        add_target python-3-13
        ;;
      dotnet/9/*)
        add_target dotnet-9
        ;;
      dotnet/10/*)
        add_target dotnet-10
        ;;
      go/1.24/*)
        add_target go-1-24
        ;;
      wine/10/*)
        add_target wine-10
        ;;
      games/generic/*)
        add_target games-generic
        add_games_dependents
        ;;
      games/source/*)
        add_target games-source
        ;;
      games/unity/*)
        add_target games-unity
        ;;
      steamcmd/debian/*)
        add_target steamcmd-debian
        ;;
      installers/debian/*)
        add_target installers-debian
        ;;
      installers/java/21/*)
        add_target installers-java-21
        ;;
      installers/dotnet/10/*)
        add_target installers-dotnet-10
        ;;
    esac
  done < <(git diff --name-only "${BASE_SHA}" "${HEAD_SHA}")
fi

targets="$(json_array)"
count="${#SELECTED[@]}"

echo "targets=${targets}"
echo "count=${count}"

if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
  {
    echo "targets=${targets}"
    echo "count=${count}"
  } >> "${GITHUB_OUTPUT}"
fi
