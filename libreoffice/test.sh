
docker run --rm -it \
-e "TZ=Asia/Shanghai" \
sorc/libreoffice:latest


docker run --rm -it ubuntu:20.04 /bin/bash
docker run --rm -it ubuntu:22.04 /bin/bash
docker run --rm -it ubuntu:24.04 /bin/bash
apt update && apt search libreoffice |grep libreoffice/


docker  build \
  -f Dockerfile.test \
  --build-arg VER=7.3 \
  --build-arg UBUNTU_VER=22.04 \
  --build-arg JDK_VER=openjdk-8-jre \
  --output=type=docker \
  --tag sorc/test:latest .