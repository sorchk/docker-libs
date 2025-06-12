#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOCK_FILE="/var/run/tailscale/tailscaled.sock"
LOG_FILE="$SCRIPT_DIR/tailscaled_check.log"
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" | tee -a "$LOG_FILE"
}
# 检查 tailscaled.sock 是否存在
if [ ! -S "$SOCK_FILE" ]; then
    log "tailscaled.sock 不存在，正在重启 tailscaled 服务..."
    systemctl restart tailscaled
    sleep 3
    # 再次检查 tailscaled.sock
    if [ -S "$SOCK_FILE" ]; then
        log "tailscaled.sock 存在，正在重启 derper 服务..."
        docker restart tailscale-derp
    fi
fi

