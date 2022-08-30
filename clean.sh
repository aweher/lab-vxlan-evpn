#!/bin/bash
sudo clab destroy --topo topology.yml --cleanup
sudo rm -rf ./.venv-local
sudo rm -rf ./topology.yml
sudo rm -rf ./*.bak
sudo rm -rf ./.*.bak
sudo rm -rf ./clab-vxlan-evpn
sudo rm -rf ./general-configs/daemons~