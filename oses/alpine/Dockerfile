# syntax=docker/dockerfile:1.7

FROM alpine:3.21

ARG IMAGE_SOURCE="https://github.com/Shardbyte/shard-yolk-basket"
ARG IMAGE_REVISION="unknown"
ARG IMAGE_CREATED="unknown"
ARG CONTAINER_UID="1000"
ARG CONTAINER_GID="1000"

LABEL org.opencontainers.image.title="Shard Yolk Basket Alpine 3.21"
LABEL org.opencontainers.image.description="Minimal Alpine 3.21 runtime base for Pelican yolks requiring a lightweight musl-based image."
LABEL org.opencontainers.image.source="${IMAGE_SOURCE}"
LABEL org.opencontainers.image.revision="${IMAGE_REVISION}"
LABEL org.opencontainers.image.created="${IMAGE_CREATED}"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.vendor="Shardbyte"

ENV USER=container
ENV HOME=/home/container

RUN apk add --no-cache \
      bash \
      ca-certificates \
      curl \
      git \
      iproute2 \
      procps \
      tini \
      tzdata \
      unzip \
      wget \
      xz \
      zip \
    && addgroup -g "${CONTAINER_GID}" container \
    && adduser -D -u "${CONTAINER_UID}" -G container -h /home/container -s /bin/bash container \
    && ln -s /home/container /nonexistent

WORKDIR /home/container

# hadolint ignore=DL3022
COPY --chmod=0755 --chown=container:container --from=base /entrypoint.sh /entrypoint.sh

USER container
STOPSIGNAL SIGINT
HEALTHCHECK NONE

ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD ["/entrypoint.sh"]
