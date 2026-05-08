# syntax=docker/dockerfile:1.7

# hadolint ignore=DL3006
FROM base

ARG IMAGE_SOURCE="https://github.com/Shardbyte/shard-yolk-basket"
ARG IMAGE_REVISION="unknown"
ARG IMAGE_CREATED="unknown"

LABEL org.opencontainers.image.title="Shard Yolk Basket Debian Trixie Java"
LABEL org.opencontainers.image.description="Debian 13 OpenJDK runtime layer for Pelican yolks."
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
      openjdk-21-jre-headless \
    && ln -s "/usr/lib/jvm/java-21-openjdk-$(dpkg --print-architecture)" /opt/java \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/opt/java

USER container
