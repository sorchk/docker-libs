#!/bin/sh
if [ -n "${VKEY}" ];then
  echo "start npc with server:${SERVER}, vkey${VKEY}"
  /home/npc/npc -server=${SERVER} -vkey=${VKEY} -type=tcp
elif [ -n "${CONFIG}" ];then
  echo "start npc with config: ${CONFIG}"
  /home/npc/npc -config=${CONFIG}
else
  echo "请使用SERVER和VKEY环境变量分别设置服务器地址和密钥，或使用环境变量CONFIG指定配置文件路径"
fi