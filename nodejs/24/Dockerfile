# syntax=docker/dockerfile:1.7

FROM node:24-trixie-slim

ARG IMAGE_SOURCE="https://github.com/Shardbyte/shard-yolk-basket"
ARG IMAGE_REVISION="unknown"
ARG IMAGE_CREATED="unknown"
ARG CONTAINER_UID="1000"
ARG CONTAINER_GID="1000"

LABEL org.opencontainers.image.title="Shard Yolk Basket Node.js 24"
LABEL org.opencontainers.image.description="Debian 13 Node.js 24 LTS runtime layer for Pelican yolks."
LABEL org.opencontainers.image.source="${IMAGE_SOURCE}"
LABEL org.opencontainers.image.revision="${IMAGE_REVISION}"
LABEL org.opencontainers.image.created="${IMAGE_CREATED}"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.vendor="Shardbyte"

ENV DEBIAN_FRONTEND=noninteractive
ENV USER=container
ENV HOME=/home/container

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get update \
    && apt-get install -y --no-install-recommends \
      bash \
      ca-certificates \
      curl \
      git \
      iproute2 \
      locales \
      netcat-openbsd \
      procps \
      tini \
      tzdata \
      unzip \
      wget \
      xz-utils \
      zip \
    && sed -i 's/^# *\(en_US.UTF-8 UTF-8\)/\1/' /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 \
    && existing_group="$(getent group "${CONTAINER_GID}" | cut -d: -f1 || true)" \
    && if [ -n "${existing_group}" ] && [ "${existing_group}" != "container" ]; then groupmod -n container "${existing_group}"; \
       elif [ -z "${existing_group}" ]; then groupadd --gid "${CONTAINER_GID}" container; fi \
    && existing_user="$(getent passwd "${CONTAINER_UID}" | cut -d: -f1 || true)" \
    && if [ -n "${existing_user}" ] && [ "${existing_user}" != "container" ]; then usermod --login container --home /home/container --move-home --shell /bin/bash "${existing_user}"; \
       elif [ -z "${existing_user}" ]; then useradd --uid "${CONTAINER_UID}" --gid "${CONTAINER_GID}" --create-home --home-dir /home/container --shell /bin/bash container; fi \
    && chown -R container:container /home/container \
    && ln -s /home/container /nonexistent \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

WORKDIR /home/container

# hadolint ignore=DL3022
COPY --chmod=0755 --chown=container:container --from=base /entrypoint.sh /entrypoint.sh

USER container
STOPSIGNAL SIGINT
HEALTHCHECK NONE

ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
CMD ["/entrypoint.sh"]
