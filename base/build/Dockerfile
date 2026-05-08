# syntax=docker/dockerfile:1.7

# hadolint ignore=DL3006
FROM base

ARG IMAGE_SOURCE="https://github.com/Shardbyte/shard-yolk-basket"
ARG IMAGE_REVISION="unknown"
ARG IMAGE_CREATED="unknown"

LABEL org.opencontainers.image.title="Shard Yolk Basket Debian Trixie Build"
LABEL org.opencontainers.image.description="Debian 13 build tooling layer for compiling and packaging game servers."
LABEL org.opencontainers.image.source="${IMAGE_SOURCE}"
LABEL org.opencontainers.image.revision="${IMAGE_REVISION}"
LABEL org.opencontainers.image.created="${IMAGE_CREATED}"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.vendor="Shardbyte"

USER root

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get update \
    && apt-get install -y --no-install-recommends \
      binutils \
      build-essential \
      clang \
      cmake \
      gdb \
      jq \
      make \
      ninja-build \
      pkg-config \
      python3 \
      rsync \
      tar \
    && rm -rf /var/lib/apt/lists/*

USER container
