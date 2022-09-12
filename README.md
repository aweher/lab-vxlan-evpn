# LACNOG VXLAN & EVPN LAB

Virtual Lab to be used during the [LACNOG2022](https://nog.lat) event.

Important note: This repository is under constant development until the tutorial day. Please be aware of the changes after every clone/pull.

## Installation

This is based in a clean install of an Ubuntu Linux 22.04 LTS server.

### Install Docker

```bash
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg lsb-release jq python3-venv

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo usermod -aG docker $USER

sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```

### Docker daemon configuration

```bash
sudo cat <<'EOF'> /etc/docker/daemon.json
{
    "bip": "198.18.64.1/24",
    "ipv6": true,
    "fixed-cidr-v6": "2001:db8:dada::/64"
}
EOF

sudo systemctl restart docker
```

### Install Docker Compose

```bash
sudo curl -SL https://github.com/docker/compose/releases/download/v2.7.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod 755 /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

### Install ContainerLab

```bash
echo "deb [trusted=yes] https://apt.fury.io/netdevops/ /" | \
sudo tee -a /etc/apt/sources.list.d/netdevops.list

apt update && apt install -y containerlab
```

### Clone this repository

```bash
# Clone
git clone https://github.com/aweher/lab-vxlan-evpn.git

# Request a token from mysocketio.dev if you need to publish some ports to the internet
sudo containerlab tools mysocketio login -e email@dominio.com

# Execute project
bash ./run.sh
```

### How to connect to an instance

```bash
# List all the running instances
sudo containerlab inspect -a

# Example: connecting to the FRR instance with name lacnog2022-vxlan-evpn-spine2
docker exec -ti lacnog2022-vxlan-evpn-spine2 vtysh
```

### Stop the lab and delete all files

```bash
bash clean.sh
```

## Authors

* Ariel S. Weher <ariel[at]weher.net>
* Nicolás Antoniello <nantoniello[at]nog.lat>
* Carlos Martinez - Cagnazzo <cmartinez[at]nog.lat>
