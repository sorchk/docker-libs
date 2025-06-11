# 编译
FROM golang:alpine AS builder
ARG VER
# 切换模块源为中国Go模块代理服务器
RUN go env -w GOPROXY=https://goproxy.cn,direct
# 拉取代码
RUN go install tailscale.com/cmd/derper@v${VER}
# 编译
RUN cd /go/pkg/mod/tailscale.com@v${VER}/cmd/derper && \
    go build -o /etc/derp/derper
# 生成最终镜像
FROM alpine:latest
ENV HOSTNAME=tsd.sction.org
ENV PORT=443
ENV STUN_PORT=3478
ENV CERT_MODE=manual
ENV CERT_DIR=/apps/certdir
ENV HTTP_PORT=-1
ENV HOME_URL=blank
ENV LANG=C.UTF-8
# derpprobe 环境变量
ENV PROBE_INTERVAL=10s

WORKDIR /apps
COPY --from=builder /etc/derp/derper .

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezone
# 创建软链接 解决二进制无法执行问题 Amd架构必须执行，Arm不需要执行
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

CMD ["sh", "-c", "./derper -hostname ${HOSTNAME} -a :${PORT} -stun-port ${STUN_PORT} -http-port=${HTTP_PORT} -certmode ${CERT_MODE} -certdir ${CERT_DIR} -home ${HOME_URL} -verify-clients"]