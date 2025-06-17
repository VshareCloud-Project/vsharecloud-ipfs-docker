FROM debian:bookworm
ENV IPFS_VERSION=v0.35.0
ENV ARCH=amd64
ENV IPFS_PATH=/data/ipfs

RUN apt install -y --no-install-recommends \
    wget \
    tar \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://dist.ipfs.io/go-ipfs/${IPFS_VERSION}/go-ipfs_${IPFS_VERSION}_linux-${ARCH}.tar.gz \
    && tar -xvzf go-ipfs_${IPFS_VERSION}_linux-${ARCH}.tar.gz \
    && sh go-ipfs/install.sh \
    && rm -rf go-ipfs go-ipfs_${IPFS_VERSION}_linux-${ARCH}.tar.gz

# Expose the ports for IPFS
EXPOSE 4001/tcp 4001/udp 5001/tcp 8080/tcp

# 初始化IPFS Repo
RUN mkdir -p /data/ipfs

RUN mkdir -p /data/ipfs-install

COPY . /data/ipfs-install

VOLUME [ "/data/ipfs" ]

CMD [ "bash", "/data/ipfs-install/install.sh" ]