ARG JAVA_VER
ARG FULL_VERSION
FROM openjdk:${JAVA_VER}
MAINTAINER sorc@qq.com
ENV TZ=Asia/Shanghai RUNCMD= RUNARGS= VERSION=${FULL_VERSION}
ADD docker-entrypoint.sh /docker-entrypoint.sh
ADD boothelper-1.0.jar /opt/app/app.jar
ADD config/tjaide_ca.crt /usr/local/share/ca-certificates/tjaide_ca.crt
ADD config/Sction_Root_CA.crt /usr/local/share/ca-certificates/Sction_Root_CA.crt
#修改源
# apt-get -y -f install inetutils-ping python curl wget telnet dnsutils traceroute net-tools && \
RUN apt-get update && \
    apt-get -y -f install inetutils-ping python curl wget telnet dnsutils traceroute net-tools && \
    chmod 644 /usr/local/share/ca-certificates/tjaide_ca.crt && \
    chmod 644 /usr/local/share/ca-certificates/Sction_Root_CA.crt && \
    chmod +x /docker-entrypoint.sh && \
    update-ca-certificates && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone
WORKDIR /app
VOLUME /app
CMD ["/docker-entrypoint.sh"]

