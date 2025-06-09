# syntax = docker/dockerfile:experimental
FROM v2fly/v2fly-core:v5.16.1
RUN apk add tzdata \
&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone \
&& apk del tzdata
