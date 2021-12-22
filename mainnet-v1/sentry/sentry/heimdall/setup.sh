#!/usr/bin/env sh

. $HOME/launch/mainnet-v1/variables.sh

NODE_DIR=$HOME/node
HEIMDALL_HOME=$MOUNT_DATA_DIR/.heimdalld

# init heimdall node
heimdalld init --home $MOUNT_DATA_DIR/.heimdalld

# copy node directories to home directories
cp -rf $NODE_DIR/heimdall/config/genesis.json $HEIMDALL_HOME/config/

# modify heimdal config
sed -i "s|^seeds =.*|$SEEDS_LINE|" $HEIMDALL_HOME/config/config.toml
sed -i "s|^eth_rpc_url =.*|eth_rpc_url = \"$ETHEREUM_IP_ADDR:8545\"|" $HEIMDALL_HOME/config/heimdall-config.toml
