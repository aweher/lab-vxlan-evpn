#!/bin/bash

source .venv-local/bin/activate || exit 1

if [ -d working-configs ]; then
  echo "working-configs directory already exists. Stopping"
  exit 1
fi

for NODE in $(python main.py | yq '.topology.nodes | to_entries | .[] | .key ' | egrep "spine|leaf" | xargs); do
  sudo mkdir -p ./working-configs/$NODE;
  sudo cp ./general-configs/daemons ./working-configs/$NODE/daemons;
  sudo cp ./general-configs/frr.conf ./working-configs/$NODE/frr.conf
  sudo cp ./general-configs/vtysh.conf ./working-configs/$NODE/vtysh.conf
done

# Configuro spines
# spine1
sudo cp -f ./general-configs/spine/spine1.conf ./working-configs/spine1/frr.conf
# spine2
sudo cp -f ./general-configs/spine/spine1.conf ./working-configs/spine2/frr.conf

sudo find ./working-configs/ -type d -exec chmod 777 {} \;
sudo find ./working-configs/ -type f -exec chmod 666 {} \;