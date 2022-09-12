# Lab Console menu

## How to deploy

```bash
sudo su
apt install -y python3-pip python3-venv
mkdir -p /opt/lacnog-labs/vxlan-evpn
cp *.py /opt/lacnog-labs/vxlan-evpn/
cp shellmenu.sh /opt/lacnog-labs/vxlan-evpn/
cd /opt/lacnog-labs/vxlan-evpn/
python3 -m venv .venv
chmod 755 /opt/lacnog-labs/vxlan-evpn/shellmenu.sh
source ./.venv/bin/activate
pip install -U colorama clint pyfiglet
echo "/opt/lacnog-labs/vxlan-evpn/shellmenu.sh" >> /etc/shells

# Add a username with this shell defined
useradd -m -s /opt/lacnog-labs/vxlan-evpn/shellmenu.sh lablacnog
passwd lablacnog
```
