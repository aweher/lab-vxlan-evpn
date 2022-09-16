#!/bin/bash

clear
echo "LACNOG LAB VXLAN & EVPN"
echo
echo "You are about to create several docker instances and"
echo "the required files for running a complex Lab"
echo 
echo "Press enter to continue, Ctrl+C to cancel..."

read key

sudo ip link add bridge-domain type bridge
sudo ip link set bridge-domain up

python3 -m venv .venv-local && source .venv-local/bin/activate && pip install -r requirements.txt
python3 main.py > topology.yml
if [ -f topology.yml ]; then
  ./mkconfigs.sh
  sudo containerlab deploy --topo topology.yml
fi
