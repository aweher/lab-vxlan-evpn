#!/bin/sh
python3 -m venv .venv-local && source .venv-local/bin/activate && pip install -r requirements.txt
python3 main.py > topology.yml
if [ -f topology.yml ]; then
  sudo clab deploy --topo topology.yml
fi
