#!/usr/bin/env sh

. ../../../variables.sh

NODE_DIR=$HOME/node
HEIMDALL_HOME=$HOME/.heimdalld

# init heimdall node
heimdalld init

# copy node directories to home directories
cp -rf $NODE_DIR/heimdall/config/genesis.json $HEIMDALL_HOME/config/

# modify heimdal config
sed -i "s|^seeds =.*|$SEEDS_LINE|" $HEIMDALL_HOME/config/config.toml
sed -i "s|^eth_rpc_url =.*|$ETHEREUM_RPC_URI|" $HEIMDALL_HOME/config/heimdall-config.toml

# copy .heimdal to mount directory
cp -rf $HEIMDALL_HOME $MOUNT_DATA_DIR
