# syntax = docker/dockerfile:experimental
ARG UBUNTU_VER
FROM ubuntu:$UBUNTU_VER
ENV TZ=Asia/Shanghai
ARG JDK_VER
COPY fonts/* /usr/share/fonts/chinese/
RUN apt-get clean && apt-get update && \
	cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	echo "Asia/Shanghai" > /etc/timezone &&\
	sed -i 's/http:\/\/archive.ubuntu.com/https:\/\/mirrors.aliyun.com/g' /etc/apt/sources.list &&\
	sed -i 's/# deb/deb/g' /etc/apt/sources.list &&\
	apt-get install -y --reinstall ca-certificates &&\
	apt-get clean && apt-get update &&\
	apt-get install -y locales language-pack-zh-hans &&\
	localedef -i zh_CN -c -f UTF-8 -A /usr/share/locale/locale.alias zh_CN.UTF-8 && locale-gen zh_CN.UTF-8 &&\
    export DEBIAN_FRONTEND=noninteractive &&\
	apt-get install -y tzdata && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&\
	apt-get install -y fontconfig ttf-mscorefonts-installer ttf-wqy-microhei ttf-wqy-zenhei xfonts-wqy &&\
	apt-get install -y wget curl
# 安装jre8
RUN apt install -y $JDK_VER
# 安装libreoffice
RUN apt install -y libreoffice libreoffice-l10n-zh-cn libreoffice-l10n-zh-tw
# 安装字体
RUN mkfontscale && \
    mkfontdir && \
    fc-cache -fv
ENV LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8
CMD ["/bin/bash"]
