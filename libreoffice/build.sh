#!/bin/bash
name=libreoffice
ver=$1
build_date=`date +"%Y%m%d"`
if [ -z "${ver}" ] ;then
  ver=jre8
fi
echo ${ver}_${build_date}
export DOCKER_CLI_EXPERIMENTAL=enabled
echo ${DOCKER_HUB_KEY} | docker login --username ${docker_user}  --password-stdin
docker buildx build \
  --platform linux/arm64,linux/amd64 \
  --build-arg VER=${ver} \
  --build-arg BUILD_DATE=${build_date} \
  --push \
  --tag sorc/${name}:${ver}_${build_date} \
  --tag sorc/${name}:${ver} \
  --tag sorc/${name}:latest .