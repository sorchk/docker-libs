#!/bin/bash
name=netool
ver0=bookworm-20231218
ver1=bookworm
ver2=12

#登录镜像仓库
docker_user=sorc
cat key.bak  | docker login --username ${docker_user}  --password-stdin
#构建镜像
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --build-arg VER=${ver1} \
  --build-arg HTTP_PROXY=http://10.10.10.41:1083 \
  --build-arg HTTPS_PROXY=http://10.10.10.41:1083 \
  --push \
  --tag sorc/${name}:${ver0} \
  --tag sorc/${name}:${ver1} \
  --tag sorc/${name}:${ver2}  \
  --tag sorc/${name}:latest .
