#!/bin/bash
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf


# 需要先安装 Tailscale
curl -fsSL https://tailscale.com/install.sh | sh
# sudo apt-get update
# sudo apt-get install tailscale
sudo tailscale up --accept-routes --advertise-exit-node --reset
# sudo tailscale up --accept-routes --advertise-exit-node --advertise-routes 192.168.1.0/24 --reset
