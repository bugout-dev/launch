#!/usr/bin/env sh

NODE_DIR=${NODE_DIR:-$HOME/node}
BIN_DIR=$(go env GOPATH)/bin
USER=$(whoami)


VALIDATOR_ADDRESS='${VALIDATOR_ADDRESS}'
MOUNT_DATA_DIR='${MOUNT_DATA_DIR}'
BOR_BOOTNODES='${BOR_BOOTNODES}'

cat > metadata <<EOF
VALIDATOR_ADDRESS=
EOF

cat > bor.service <<EOF
[Unit]
  Description=bor
  StartLimitIntervalSec=500
  StartLimitBurst=5
  After=network.target

[Service]
  Restart=on-failure
  RestartSec=5s
  WorkingDirectory=$NODE_DIR
  EnvironmentFile=/etc/matic/metadata
  EnvironmentFile=$NODE_DIR/variables.env
  EnvironmentFile=/home/ubuntu/moonstream-secrets/app.env
  ExecStart=/home/ubuntu/go/bin/bor --datadir "$MOUNT_DATA_DIR/.bor/data" \
    --port 30303 \
    --http --http.addr "${AWS_LOCAL_IPV4}" \
    --http.vhosts '*' \
    --http.corsdomain '*' \
    --http.port 8545 \
    --ipcpath "$MOUNT_DATA_DIR/.bor/data/bor.ipc" \
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
  Type=simple
  User=$USER
  KillSignal=SIGINT
  TimeoutStopSec=300
  SyslogIdentifier=bor

[Install]
  WantedBy=multi-user.target
EOF

cat > heimdalld.service <<EOF
[Unit]
  Description=heimdalld
  StartLimitIntervalSec=500
  StartLimitBurst=5

[Service]
  Restart=on-failure
  RestartSec=5s
  WorkingDirectory=$NODE_DIR
  EnvironmentFile=$NODE_DIR/variables.env
  ExecStart=$BIN_DIR/heimdalld start --home "$MOUNT_DATA_DIR/.heimdalld" --with-heimdall-config "$MOUNT_DATA_DIR/.heimdalld/config/heimdall-config.toml"
  Type=simple
  User=$USER

[Install]
  WantedBy=multi-user.target
EOF

cat > heimdalld-rest-server.service <<EOF
[Unit]
  Description=heimdalld-rest-server
  StartLimitIntervalSec=500
  StartLimitBurst=5

[Service]
  Restart=on-failure
  RestartSec=5s
  WorkingDirectory=$NODE_DIR
  EnvironmentFile=$NODE_DIR/variables.env
  ExecStart=$BIN_DIR/heimdalld rest-server --home "$MOUNT_DATA_DIR/.heimdalld" --with-heimdall-config "$MOUNT_DATA_DIR/.heimdalld/config/heimdall-config.toml"
  Type=simple
  User=$USER

[Install]
  WantedBy=multi-user.target
EOF

cat > heimdalld-bridge.service <<EOF
[Unit]
  Description=heimdalld-bridge

[Service]
  WorkingDirectory=$NODE_DIR
  EnvironmentFile=$NODE_DIR/variables.env
  ExecStart=$BIN_DIR/bridge start --home "$MOUNT_DATA_DIR/.heimdalld" --with-heimdall-config "$MOUNT_DATA_DIR/.heimdalld/config/heimdall-config.toml" --all
  Type=simple
  User=$USER

[Install]
  WantedBy=multi-user.target
EOF
