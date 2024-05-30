#!/bin/bash
name=kafka
java_ver=$1
ver=$2
if [ -z "${java_ver}" ] ;then
  java_ver=8-jdk
fi
if [ -z "${ver}" ] ;then
  ver=2.13-3.2.0
fi
build_date=`date +"%Y%m%d"`
full_version=${java_ver}_${ver}_${build_date}
echo ${full_version}

#登录镜像仓库
echo ${DOCKER_HUB_KEY} | docker login --username ${DOCKER_HUB_USER} --password-stdin

#
#登录失败需要安装 sudo apt install gnupg2 pass
#sudo docker tag sorc/${name} sorc/${name}:${ver}
#将镜像推到仓库
docker push sorc/${name}:${full_version}
docker push sorc/${name}:latest
