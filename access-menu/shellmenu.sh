#!/bin/bash
trap '' SIGINT
trap '' SIGTSTP

cd /opt/lacnog-labs/vxlan-evpn

source ./.venv/bin/activate
python3 main.py