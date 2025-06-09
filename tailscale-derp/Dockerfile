# 编译
FROM golang:alpine AS builder
ARG VER
# 切换模块源为中国Go模块代理服务器
RUN go env -w GOPROXY=https://goproxy.cn,direct
# 拉取代码
RUN go install tailscale.com/cmd/derper@v${VER}
# 编译
RUN derper_dir=$(find /go/pkg/mod/tailscale.com@*/cmd/derper -type d) && \
	cd $derper_dir && \
    go build -o /etc/derp/derper

RUN go install tailscale.com/cmd/derpprobe@v${VER}
# 编译
RUN derpprobe_dir=$(find /go/pkg/mod/tailscale.com@*/cmd/derpprobe -type d) && \
    cd $derpprobe_dir && \
    go build -o /etc/derp/derpprobe

# 生成最终镜像
FROM alpine:latest
ENV HOSTNAME=tsd.sction.org
ENV PORT=443
ENV STUN_PORT=3478
ENV LANG=C.UTF-8
ENV HTTP_PORT=-1
ENV CERT_MODE=manual
ENV CERT_DIR=/apps/certdir
# derpprobe 环境变量
ENV PROBE_INTERVAL=10s

WORKDIR /apps
COPY --from=builder /etc/derp/derper .
COPY --from=builder /etc/derp/derpprobe .


RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezone
# 创建软链接 解决二进制无法执行问题 Amd架构必须执行，Arm不需要执行
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

# 创建启动脚本
RUN echo '#!/bin/sh' > start.sh && \
    echo './derper -hostname ${HOSTNAME} -a :${PORT} -http-port=${HTTP_PORT} -stun-port ${STUN_PORT} -certmode ${CERT_MODE} -certdir ${CERT_DIR}  -home blank -verify-clients &' >> start.sh && \
    echo './derpprobe -derp-map local -interval ${PROBE_INTERVAL}' >> start.sh && \
    chmod +x start.sh
# 修改CMD使用启动脚本
CMD ["./start.sh"]