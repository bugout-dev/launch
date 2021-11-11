#!/usr/bin/env sh

set -x #echo on

. $HOME/launch/mainnet-v1/variables.sh

BOR_DIR=$MOUNT_DATA_DIR/.bor
DATA_DIR=$BOR_DIR/data

LOCAL_IP="$(ec2metadata --local-ipv4)"
MOONSTREAM_NODE_POLYGON_IPC_PORT="${MOONSTREAM_NODE_POLYGON_IPC_PORT:-18350}"

/home/ubuntu/go/bin/bor --datadir $DATA_DIR \
  --port 30303 \
  --http --http.addr "$LOCAL_IP" \
  --http.vhosts '*' \
  --http.corsdomain '*' \
  --http.port "$MOONSTREAM_NODE_POLYGON_IPC_PORT" \
  --ipcpath $DATA_DIR/bor.ipc \
  --http.api 'eth,net,web3,txpool,bor' \
  --syncmode 'full' \
  --networkid '137' \
  --miner.gasprice '30000000000' \
  --miner.gaslimit '20000000' \
  --miner.gastarget '20000000' \
  --txpool.nolocals \
  --txpool.accountslots 16 \
  --txpool.globalslots 131072 \
  --txpool.accountqueue 64 \
  --txpool.globalqueue 131072 \
  --txpool.lifetime '1h30m0s' \
  --maxpeers 200 \
  --metrics \
  --pprof --pprof.port 7071 --pprof.addr '0.0.0.0' \
  --bootnodes "$BOR_BOOTNODES"
