#!/bin/bash
name=boothelper
#openjdk:8u342-jdk-bullseye 225.98MB
#openjdk:8u342-slim-bullseye 132.69MB

#openjdk:11-jdk-bullseye 317.68MB
#openjdk:11-slim-bullseye

#openjdk:22-ea-17-jdk-bookworm
#openjdk:17-jdk-bullseye 312.09MB
#openjdk:17-slim-bullseye 210.63MB

#openjdk:22-ea-21-jdk-bookworm
#openjdk:21-jdk-bookworm
#openjdk:21-slim-bookworm
#java_ver=17-slim-bullseye
build_date=$(date +"%Y%m%d")
full_version=${java_ver}-${build_date}
echo ${full_version}
#登录镜像仓库
docker_user=sorc
cat key.bak  | docker login --username ${docker_user}  --password-stdin
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --build-arg JAVA_VER=${java_ver} \
  --build-arg FULL_VERSION=${full_version} \
  --build-arg HTTP_PROXY=http://10.10.10.41:1083 \
  --build-arg HTTPS_PROXY=http://10.10.10.41:1083 \
  --push \
  --tag sorc/${name}:${full_version} \
  --tag sorc/${name}:${java_ver} .
