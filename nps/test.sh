#!/bin/bash
docker rmi -f sorc/nps:latest
docker rm -f nps_test
sudo rm -rf $(pwd)/conf
docker run -d \
--restart=always \
--network host \
-e TZ="Asia/Shanghai" \
-e HTTPS_PROXY_PORT=8444 \
-e WEB_HOST="localhost" \
-e WEB_PASSWORD="admin\!1231qaz" \
-v $(pwd)/conf:/etc/nps/conf \
--name nps_test \
sorc/nps

docker rm -f nps
docker run -d \
--restart=always \
--network host \
-e TZ="Asia/Shanghai" \
-e HTTP_PROXY_PORT=18080 \
-e HTTPS_PROXY_PORT=18443 \
-e WEB_HOST="localhost" \
-e WEB_PASSWORD="a8i3d2e9,." \
-v /datadisk/conf/conf:/etc/nps/conf \
--name nps \
sorc/nps