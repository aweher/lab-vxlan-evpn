# LACNOG VXLAN & EVPN LAB

Laboratorio a usar durante el evento LACNOG2022

## Instalación

Basada en un servidor Ubuntu Linux 22.04 LTS recién instalado

### Instalar Docker

```bash
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg lsb-release

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

### Configurar Docker

```bash
sudo cat <<'EOF'> /etc/docker/daemon.json
{
    "bip": "198.18.64.1/24",
    "ipv6": true,
    "fixed-cidr-v6": "2001:db8:dada::/64"
}
EOF

sudo systemctl reload docker
```

### Instalar Docker Compose

```bash
sudo curl -SL https://github.com/docker/compose/releases/download/v2.7.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod 755 /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

### Instalar ContainerLab

```bash
echo "deb [trusted=yes] https://apt.fury.io/netdevops/ /" | \
sudo tee -a /etc/apt/sources.list.d/netdevops.list

apt update && apt install -y containerlab
```

### Clonar el repositorio

```bash
# Clonar
git clone https://github.com/aweher/lab-vxlan-evpn.git

# Adquirir un token de mysocketio.dev en caso de querer publicar puertos
sudo containerlab tools mysocketio login -e email@dominio.com

# Ejecutar
bash ./run.sh
```

### Conectar con una instancia

```bash
# Ejemplo: lacnog2022-vxlan-evpn-spine2
docker exec -ti lacnog2022-vxlan-evpn-spine2 /bin/ash
```

### Detener el lab y eliminar archivos

```bash
bash clean.sh
```

## Autores

* Ariel S. Weher <ariel[at]weher.net>
* Nicolás Antoniello <nantoniello[at]nog.lat>
