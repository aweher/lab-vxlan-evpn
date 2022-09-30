#!/bin/bash

echo "Press enter to destroy lab and all of its files..."
echo "Ctrl+C to cancel..."

read key

source ./.venv-local/bin/activate && python main.py > topology.yml
sudo containerlab destroy --topo topology.yml --cleanup
sudo rm -rf ./.venv-local
sudo rm -rf ./topology.yml
sudo rm -rf ./*.bak
sudo rm -rf ./.*.bak
sudo rm -rf ./clab-vxlan-evpn
sudo rm -rf ./working-configs

sudo ip link del dev bridge-domain