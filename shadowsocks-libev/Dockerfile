FROM shadowsocks/shadowsocks-libev
EXPOSE 1080 8118

USER root

RUN set -ex
RUN apk --update add --no-cache privoxy
RUN mkdir -p /etc/privoxy && \
    echo 'listen-address 0.0.0.0:8118' > /etc/privoxy/config && \
    echo 'forward-socks5 / 127.0.0.1:1080 .' >>/etc/privoxy/config
CMD ["privoxy /etc/privoxy/config"]
