#!/usr/bin/env sh

MOUNT_DATA_DIR=/mnt/disks/nodes/polygon

NODE_DIR=$HOME/node
HEIMDALL_HOME=$HOME/.heimdalld

# init heimdall node
heimdalld init

# copy node directories to home directories
cp -rf $NODE_DIR/heimdall/config/genesis.json $HEIMDALL_HOME/config/

# copy .heimdal to mount directory
cp -rf $HEIMDALL_HOME $MOUNT_DATA_DIR