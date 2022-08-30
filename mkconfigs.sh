#!/bin/bash

source .venv-local/bin/activate || exit 1

if [ -d working-configs ]; then
  echo "working-configs directory already exists. Stopping"
  exit 1
fi

for NODE in $(python main.py | yq '.topology.nodes | to_entries | .[] | .key ' | grep -E "leaf|spine" | xargs); do
  sudo mkdir -p ./working-configs/$NODE; 
done

for NODE in $(python main.py | yq '.topology.nodes | to_entries | .[] | .key ' | grep -E "leaf|spine" | xargs); do 
  if [ -d ./general-configs/$NODE ]; then
    sudo cp ./general-configs/daemons ./working-configs/$NODE/daemons;
    sudo cp ./general-configs/frr.conf ./working-configs/$NODE/frr.conf
    sudo cp ./general-configs/vtysh.conf ./working-configs/$NODE/vtysh.conf
  fi
done

sudo find ./working-configs/ -type d -exec chmod 777 {} \;
sudo find ./working-configs/ -type f -exec chmod 666 {} \;