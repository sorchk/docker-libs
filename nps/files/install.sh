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
mkdir -p /home/nps
durl="https://github.com/ehang-io/nps/releases/download/v${npsVer}/linux_${cpuType}_server.tar.gz"
dfile="/home/nps/linux_${cpuType}_server.tar.gz"
echo "curl -L $durl -o $dfile"
curl -L $durl -o $dfile
ls -l /home/nps
tar -zxvf $dfile -C /home/nps/
rm -f $dfile
chmod +x /home/nps/nps
/home/nps/nps install
cp -rf /etc/nps/conf /etc/nps/conf_bak
rm -rf /home/nps

