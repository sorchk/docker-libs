#!/bin/bash
name=netool
ver0=bookworm-20231218-slim
ver1=bookworm-slim
ver2=12-slim

#登录镜像仓库
echo ${DOCKER_HUB_KEY} | docker login --username ${DOCKER_HUB_USER} --password-stdin
#构建镜像
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --build-arg VER=${ver1} \
  --build-arg HTTP_PROXY=http://10.10.10.41:1083 \
  --build-arg HTTPS_PROXY=http://10.10.10.41:1083 \
  --push \
  --tag sorc/${name}:${ver0} \
  --tag sorc/${name}:${ver1} \
  --tag sorc/${name}:${ver2} .
