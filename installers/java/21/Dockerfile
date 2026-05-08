# syntax=docker/dockerfile:1.7

FROM eclipse-temurin:21-jdk-noble

ARG IMAGE_SOURCE="https://github.com/Shardbyte/shard-yolk-basket"
ARG IMAGE_REVISION="unknown"
ARG IMAGE_CREATED="unknown"

LABEL org.opencontainers.image.title="Shard Yolk Basket Installer Java 21"
LABEL org.opencontainers.image.description="Java 21 JDK base for Pelican egg install scripts. Runs as root with curl, wget, git, and archive tools."
LABEL org.opencontainers.image.source="${IMAGE_SOURCE}"
LABEL org.opencontainers.image.revision="${IMAGE_REVISION}"
LABEL org.opencontainers.image.created="${IMAGE_CREATED}"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.vendor="Shardbyte"

ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get update \
    && apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      git \
      jq \
      tar \
      unzip \
      wget \
      xz-utils \
      zip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /mnt/server
HEALTHCHECK NONE
