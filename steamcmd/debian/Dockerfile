# syntax=docker/dockerfile:1.7

# hadolint ignore=DL3006
FROM generic

ARG IMAGE_SOURCE="https://github.com/Shardbyte/shard-yolk-basket"
ARG IMAGE_REVISION="unknown"
ARG IMAGE_CREATED="unknown"

LABEL org.opencontainers.image.title="Shard Yolk Basket SteamCMD Debian"
LABEL org.opencontainers.image.description="Debian 13 SteamCMD runtime for Pelican game servers. Minimal i386 compat — no Source-engine libraries."
LABEL org.opencontainers.image.source="${IMAGE_SOURCE}"
LABEL org.opencontainers.image.revision="${IMAGE_REVISION}"
LABEL org.opencontainers.image.created="${IMAGE_CREATED}"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.vendor="Shardbyte"

USER root

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
      lib32gcc-s1 \
      libcurl4:i386 \
    && install -d -o container -g container /opt/steamcmd \
    && curl -fsSL https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz \
      | tar -xz -C /opt/steamcmd \
    && chown -R container:container /opt/steamcmd \
    && chmod 0755 /opt/steamcmd/steamcmd.sh \
    && ln -s /opt/steamcmd/steamcmd.sh /usr/local/bin/steamcmd \
    && rm -rf /var/lib/apt/lists/*

USER container
