#!/bin/sh
npsVer=$1
archType=$(uname -m)
if [ $archType == "x86_64" ]; then
    cpuType="amd64"
elif [ $archType == "aarch64" ]; then
    cpuType="arm64"
else
    cpuType=$(uname -m)
fi
mkdir -p /home/npc
durl="https://github.com/ehang-io/nps/releases/download/v${npsVer}/linux_${cpuType}_client.tar.gz"
dfile="/home/npc/linux_${cpuType}_client.tar.gz"
echo "curl -L $durl -o $dfile"
curl -L $durl -o $dfile
tar -zxvf $dfile -C /home/npc/
rm -rf $dfile
chmod +x /home/npc/npc


