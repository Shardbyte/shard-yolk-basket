# syntax=docker/dockerfile:1.7

# hadolint ignore=DL3006
FROM generic

ARG IMAGE_SOURCE="https://github.com/Shardbyte/shard-yolk-basket"
ARG IMAGE_REVISION="unknown"
ARG IMAGE_CREATED="unknown"

LABEL org.opencontainers.image.title="Shard Yolk Basket Wine Game Runtime"
LABEL org.opencontainers.image.description="Debian 13 Wine compatibility runtime for Windows game servers."
LABEL org.opencontainers.image.source="${IMAGE_SOURCE}"
LABEL org.opencontainers.image.revision="${IMAGE_REVISION}"
LABEL org.opencontainers.image.created="${IMAGE_CREATED}"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.vendor="Shardbyte"

USER root

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
      cabextract \
      fonts-liberation \
      libasound2-plugins:i386 \
      libgl1:i386 \
      winbind \
      wine \
      wine32:i386 \
      xvfb \
    && rm -rf /var/lib/apt/lists/*

USER container
