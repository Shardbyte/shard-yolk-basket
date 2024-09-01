# Author: Shardbyte
# License: MIT
# Image: Redis 7.4.0 (Shard Edition for Pterodactyl)
FROM    --platform=$TARGETOS/$TARGETARCH redis:7.4.0-bookworm

ENV     DEBIAN_FRONTEND noninteractive

RUN     apt -y update && \
        apt -y upgrade && \
        apt -y install iproute2 && \
        useradd -d /home/container -m container -s /bin/bash

USER    container
ENV     USER=container HOME=/home/container
WORKDIR /home/container
RUN     chown -R container:container /home/container

COPY    ./entrypoint.sh /entrypoint.sh
COPY    ./redis.conf /usr/local/etc/redis/redis.conf
CMD     [ "/bin/bash", "/entrypoint.sh" ]
