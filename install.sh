#!/bin/bash

if [ -f $IPFS_PATH/installed ]; then
    echo "IPFS has been installed."
    ipfs daemon --migrate=true --enable-gc=true --routing=dhtclient
    exit 0
fi

# 检查是否已经安装完成
if [ -f /data/ipfs-install/installed ]; then
    echo "IPFS has been installed."
    ipfs daemon --migrate=true --enable-gc=true --routing=dhtclient
    exit 0
fi
ipfs init
bash /data/ipfs-install/ipfs-config.sh
# 安装完成
touch /data/ipfs-install/installed
touch $IPFS_PATH/installed
ipfs daemon --migrate=true --enable-gc=true --routing=dhtclient
exit 0