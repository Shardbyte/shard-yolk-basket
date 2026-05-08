# syntax=docker/dockerfile:1.7

FROM debian:trixie-slim

ARG IMAGE_SOURCE="https://github.com/Shardbyte/shard-yolk-basket"
ARG IMAGE_REVISION="unknown"
ARG IMAGE_CREATED="unknown"

LABEL org.opencontainers.image.title="Shard Yolk Basket Installer .NET 10"
LABEL org.opencontainers.image.description=".NET 10 SDK base for Pelican egg install scripts that compile game server solutions from source."
LABEL org.opencontainers.image.source="${IMAGE_SOURCE}"
LABEL org.opencontainers.image.revision="${IMAGE_REVISION}"
LABEL org.opencontainers.image.created="${IMAGE_CREATED}"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.vendor="Shardbyte"

ENV DEBIAN_FRONTEND=noninteractive
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_NOLOGO=1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get update \
    && apt-get install -y --no-install-recommends \
      ca-certificates \
      gpg \
      wget \
    && wget -nv https://packages.microsoft.com/keys/microsoft-2025.asc -O microsoft-2025.asc \
    && gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg microsoft-2025.asc \
    && wget -nv https://packages.microsoft.com/config/debian/13/prod.list -O /etc/apt/sources.list.d/microsoft-prod.list \
    && rm microsoft-2025.asc \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
      curl \
      dotnet-sdk-10.0 \
      git \
      jq \
      tar \
      unzip \
      zip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /mnt/server
HEALTHCHECK NONE
