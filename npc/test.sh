#!/bin/bash
docker rm -f npc_test
docker run -d \
--name npc_test \
--restart always \
--net host \
-e TZ="Asia/Shanghai" \
-e SERVER="mgrip.sction.org:1440" \
-e VKEY="test123456789test0" \
sorc/npc:latest

docker rm -f npc_test
docker run -d \
--name npc_test \
--restart always \
--net host \
-e TZ="Asia/Shanghai" \
-e SERVER="192.168.200.1:1440" \
-e VKEY="o2tc93233nk9mo4i" \
sorc/npc:latest

