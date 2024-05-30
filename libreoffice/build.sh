#!/bin/bash
name=libreoffice
ver=$1
ubuntu_ver=22.04
jdk_ver=openjdk-8-jre
build_date=`date +"%Y%m%d"`
if [ -z "${ver}" ] ;then
  ver=7.3
fi
echo ${ver}_${build_date}
# export DOCKER_CLI_EXPERIMENTAL=enabled
# export http_proxy=socks5://127.0.0.1:1080
# export https_proxy=socks5://127.0.0.1:1080
echo ${DOCKER_HUB_KEY} | docker login --username ${DOCKER_HUB_USER} --password-stdin
docker buildx build \
  --platform linux/arm64,linux/amd64 \
  --build-arg VER=${ver} \
  --build-arg UBUNTU_VER=${ubuntu_ver} \
  --build-arg JDK_VER=${jdk_ver} \
  --build-arg BUILD_DATE=${build_date} \
  --push \
  --tag sorc/${name}:${ver}_${jdk_ver}_${build_date} \
  --tag sorc/${name}:${ver}_${jdk_ver} \
  --tag sorc/${name}:${ver} \
  --tag sorc/${name}:latest .
docker logout
# unset http_proxy
# unset https_proxy