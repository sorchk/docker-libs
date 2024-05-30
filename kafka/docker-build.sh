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

#删除测试容器及镜像
docker rmi -f sorc/${name}:latest
docker rmi -f sorc/${name}:${full_version}
#构建镜像
docker build \
 --build-arg JAVA_VER=${java_ver} \
 --build-arg VER=${ver} \
 --build-arg BUILD_DATE=${build_date} \
 -t sorc/${name}:${full_version} ./
#最近版本标签
docker tag sorc/${name}:${full_version} sorc/${name}:latest

#发布测试容器
#docker run -it --rm sorc/${name}:latest
docker run -it --rm sorc/kafka:latest /bin/bash
#faf36124-xc40-4d67-91c0-424f3dx776xd
