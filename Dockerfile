FROM debian:bullseye

ENV IPFS_VERSION=v0.30.0
ENV ARCH=amd64
ENV IPFS_PATH=/data/ipfs

RUN apt-get update && apt-get install -y wget

RUN wget https://dist.ipfs.io/go-ipfs/${IPFS_VERSION}/go-ipfs_${IPFS_VERSION}_linux-${ARCH}.tar.gz \
    && tar -xvzf go-ipfs_${IPFS_VERSION}_linux-${ARCH}.tar.gz \
    && mv go-ipfs/ipfs /usr/local/bin/ipfs \
    && rm -rf go-ipfs go-ipfs_${IPFS_VERSION}_linux-${ARCH}.tar.gz

# Expose the ports for IPFS
EXPOSE 4001/tcp 4001/udp 5001/tcp 8080/tcp

# 初始化IPFS Repo
RUN mkdir -p /data/ipfs

RUN mkdir -p /data/ipfs-install

COPY . /data/ipfs-install

VOLUME [ "/data/ipfs" ]

CMD [ "bash", "/data/ipfs-install/install.sh" ]