#!/usr/bin/env sh

NODE_DIR=$HOME/node
. $NODE_DIR/variables.env
HEIMDALL_HOME=$MOUNT_DATA_DIR/.heimdalld

# init heimdall node
heimdalld init --home $HEIMDALL_HOME

# copy node directories to home directories
cp -rf $NODE_DIR/heimdall/config/genesis.json $HEIMDALL_HOME/config/