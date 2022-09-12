#!/bin/bash
trap 'Never gonna let you out' SIGINT
trap 'Never gonna let you down' SIGTSTP

cd /opt/lacnog-labs/vxlan-evpn

source ./.venv/bin/activate
python3 main.py