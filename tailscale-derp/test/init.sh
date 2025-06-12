#!/bin/bash


# 安装 Tailscale
curl -fsSL https://tailscale.com/install.sh | sh
# sudo apt-get update
# sudo apt-get install tailscale
sudo tailscale up --accept-routes --advertise-exit-node --reset
# sudo tailscale up --accept-routes --advertise-exit-node --advertise-routes 192.168.1.0/24 --reset

# 登录或配置 Tailscale
# los lax ojp oph
tailscale up --advertise-tags tag:derp --advertise-exit-node --reset
# aide
tailscale up --advertise-tags tag:serv --advertise-exit-node --advertise-routes 172.168.1.0/24 --reset
# tj
sudo tailscale up --advertise-tags tag:serv,tag:derp --advertise-exit-node --advertise-routes 192.168.1.0/24 --reset
# as 
sudo tailscale up --accept-routes --advertise-tags tag:sorc


# 使用 --advertise-routes 选项来指定要路由的子网时需要使用一下命令开启转发
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf