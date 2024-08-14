#!/bin/bash

ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "POST"]'
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["http://localhost:5001", "http://127.0.0.1:5001"]'
ipfs config --json Addresses.API '"/ip4/0.0.0.0/tcp/5001"'
ipfs config --json Addresses.Gateway '"/ip4/0.0.0.0/tcp/8080"'


ipfs config --json Internal.Bitswap.TaskWorkerCount 256
ipfs config --json Internal.Bitswap.TaskWorkerCount 512
ipfs config --json Internal.Bitswap.EngineBlockstoreWorkerCount 4096
ipfs config --json Internal.Bitswap.EngineTaskWorkerCount 512
ipfs config --json Swarm.RelayService.Enabled true
ipfs config --json Reprovider.Interval '"1h"'

# 配置Tracker
declare -A trackers=(
    ["checkpoint-hk.ipns.network"]="12D3KooWCw9LKX6uncp1a6SuoPoNWmz7t1BSVo9YdHRJ3t15Yk2h"
    ["checkpoint-cn.yeaosound.com"]="12D3KooWPcsUwx3doGMbsLsoi5Ks8mVRkd1mGrZuUjfqWLdpPTks"
)

bootstrap_config=""
peering_config="["

for domain in "${!trackers[@]}"; do
    id=${trackers[$domain]}
    bootstrap_config+="ipfs bootstrap add /dns4/$domain/tcp/4001/p2p/$id"$'\n'
    peering_config+="{\"Addrs\": [\"/dns4/$domain/tcp/4001\", \"/dns4/$domain/udp/4001/quic\"], \"ID\": \"$id\"},"
done
# 去掉最后一个逗号
peering_config="${peering_config%,}]"

# 添加 bootstrap 和 peering 配置
eval "$bootstrap_config"
ipfs config --json Peering.Peers "$peering_config"
# 配置连接管理器
ipfs config --json Swarm.ConnMgr '{"GracePeriod": "30s","HighWater": 1024,"LowWater": 512,"Type": "basic"}'
ipfs config --json Datastore.GCPeriod '"12h"'
