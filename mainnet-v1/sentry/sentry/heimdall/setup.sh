#!/usr/bin/env sh

MOUNT_DATA_DIR=/mnt/disks/nodes/polygon

NODE_DIR=$HOME/node
HEIMDALL_HOME=$HOME/.heimdalld

# init heimdall node
heimdalld init

# copy node directories to home directories
cp -rf $NODE_DIR/heimdall/config/genesis.json $HEIMDALL_HOME/config/

# add seeds
SEEDS_LINE='seeds = "f4f605d60b8ffaaf15240564e58a81103510631c@159.203.9.164:26656,4fb1bc820088764a564d4f66bba1963d47d82329@44.232.55.71:26656"'
sed -i "s|^seeds =.*|$SEEDS_LINE|" $HEIMDALL_HOME/config/config.toml
ETHEREUM_RPC_URI="http://127.0.0.1:18370"
sed -i "s|^eth_rpc_url =.*|$ETHEREUM_RPC_URI|" $HEIMDALL_HOME/config/heimdall-config.toml

# copy .heimdal to mount directory
cp -rf $HEIMDALL_HOME $MOUNT_DATA_DIR