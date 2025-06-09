#!/bin/bash
name=v2ray
ver=$1
build_date=`date +"%Y%m%d"`
if [ -z "${ver}" ] ;then
  ver=5.16.1
fi
echo ${ver}_${build_date}
export DOCKER_CLI_EXPERIMENTAL=enabled
echo ${DOCKER_HUB_KEY} | docker login --username ${DOCKER_HUB_USER} --password-stdin
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --build-arg VER=${ver} \
  --build-arg BUILD_DATE=${build_date} \
  --push \
  --tag sorc/${name}:${ver}_${build_date} \
  --tag sorc/${name}:${ver} \
  --tag sorc/${name}:latest .


  # --build-arg HTTP_PROXY=http://10.10.10.41:1083 \
  # --build-arg HTTPS_PROXY=http://10.10.10.41:1083 \