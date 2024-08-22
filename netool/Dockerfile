# syntax = docker/dockerfile:experimental
ARG VER
FROM debian:${VER}
MAINTAINER sorc@qq.com
ENV TZ=Asia/Shanghai
ADD config/tjaide_ca.crt /usr/local/share/ca-certificates/tjaide_ca.crt
ADD config/Sction_Root_CA.crt /usr/local/share/ca-certificates/Sction_Root_CA.crt
RUN apt-get update && \
    apt-get -y install curl wget telnet openssh-client inetutils-ping iproute2 dnsutils traceroute net-tools sysstat tcpdump mtr-tiny nmap && \
    chmod 644 /usr/local/share/ca-certificates/tjaide_ca.crt && \
    chmod 644 /usr/local/share/ca-certificates/Sction_Root_CA.crt && \
    update-ca-certificates && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone
CMD ["/bin/bash","-c","sleep 3600"]
