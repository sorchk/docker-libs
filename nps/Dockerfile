# syntax = docker/dockerfile:experimental
FROM alpine:3.18.4
MAINTAINER sorc@qq.com
ARG VER
ENV TZ="Asia/Shanghai"
ADD files/docker-entrypoint.sh /
ADD files/install.sh /tmp/
RUN apk add curl --virtual .build-dependencies --no-cache openssl
RUN chmod +x /docker-entrypoint.sh \
&& chmod +x /tmp/install.sh \
&& /tmp/install.sh ${VER} \
&& rm -rf /tmp/install.sh

RUN apk del .build-dependencies
VOLUME /etc/nps/conf
WORKDIR /etc/nps
EXPOSE 8181 8443 1440 1441
ENTRYPOINT ["/docker-entrypoint.sh"]
