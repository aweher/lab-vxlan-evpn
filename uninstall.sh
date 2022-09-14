#!/bin/bash

clear
echo "LACNOG LAB VXLAN & EVPN"
echo
echo "You are about to destroy all instances and remove all unused container images"
echo 
echo "Press enter to continue, Ctrl+C to cancel..."

read key

docker kill $(docker ps | grep frr | awk '{print $1}' | xargs)
docker kill $(docker ps | grep multitool | awk '{print $1}' | xargs)
docker image prune
docker container prune