# syntax=docker/dockerfile:1.7

# Java 11 is not in Debian 13 (trixie) apt. Installed via the Adoptium apt
# repository on the Debian 13 base so the OS layer stays consistent with
# all other yolks. For Minecraft 1.12.1 through 1.16.5 and related Forge.
# hadolint ignore=DL3006
FROM base

ARG IMAGE_SOURCE="https://github.com/Shardbyte/shard-yolk-basket"
ARG IMAGE_REVISION="unknown"
ARG IMAGE_CREATED="unknown"

LABEL org.opencontainers.image.title="Shard Yolk Basket Debian Trixie Java 11"
LABEL org.opencontainers.image.description="Eclipse Temurin 11 JDK runtime from the Adoptium apt repository for legacy Java game servers."
LABEL org.opencontainers.image.source="${IMAGE_SOURCE}"
LABEL org.opencontainers.image.revision="${IMAGE_REVISION}"
LABEL org.opencontainers.image.created="${IMAGE_CREATED}"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.vendor="Shardbyte"

USER root

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    mkdir -p /etc/apt/keyrings \
    && wget -qO /etc/apt/keyrings/adoptium.asc \
         https://packages.adoptium.net/artifactory/api/gpg/key/public \
    && echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb trixie main" \
         > /etc/apt/sources.list.d/adoptium.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
      temurin-11-jdk \
    && ln -s "/usr/lib/jvm/temurin-11-jdk-$(dpkg --print-architecture)" /opt/java \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/opt/java

USER container
