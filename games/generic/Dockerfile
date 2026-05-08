# syntax=docker/dockerfile:1.7

# hadolint ignore=DL3006
FROM runtime

ARG IMAGE_SOURCE="https://github.com/Shardbyte/shard-yolk-basket"
ARG IMAGE_REVISION="unknown"
ARG IMAGE_CREATED="unknown"

LABEL org.opencontainers.image.title="Shard Yolk Basket Generic Game Runtime"
LABEL org.opencontainers.image.description="Common modern game server runtime libraries on Debian 13."
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
      bzip2 \
      jq \
      libatomic1 \
      libfontconfig1 \
      libgcc-s1 \
      libsqlite3-0 \
      libstdc++6 \
      libunwind8 \
      sqlite3 \
      tar \
    && rm -rf /var/lib/apt/lists/*

USER container
