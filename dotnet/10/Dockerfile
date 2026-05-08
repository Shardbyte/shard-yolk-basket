# syntax=docker/dockerfile:1.7

# hadolint ignore=DL3006
FROM build

ARG IMAGE_SOURCE="https://github.com/Shardbyte/shard-yolk-basket"
ARG IMAGE_REVISION="unknown"
ARG IMAGE_CREATED="unknown"

LABEL org.opencontainers.image.title="Shard Yolk Basket .NET 10 SDK"
LABEL org.opencontainers.image.description="Debian 13 .NET 10 SDK image for building modern Pelican server workloads."
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
      gpg \
    && wget -nv https://packages.microsoft.com/keys/microsoft-2025.asc -O microsoft-2025.asc \
    && gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg microsoft-2025.asc \
    && wget -nv https://packages.microsoft.com/config/debian/13/prod.list -O /etc/apt/sources.list.d/microsoft-prod.list \
    && rm microsoft-2025.asc \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
      aspnetcore-runtime-10.0 \
      dotnet-sdk-10.0 \
    && rm -rf /var/lib/apt/lists/*

ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_NOLOGO=1

USER container
