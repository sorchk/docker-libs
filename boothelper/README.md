# boothelper

这是一个spring boot 、quarkus 项目或者java 程序的辅助启动器，目的在于避免不停的打包镜像，减少时间浪费。
可以使用测试一下： docker run -it --rm sorc/boothelper:11-jdk

>docker地址：
https://hub.docker.com/r/sorc/boothelper
 
### 启动一个springboot项目
需要将springboot编译的jar复制到/datadisk/myapp/app.jar
自定义配置文件放在config目录
默认-Dspring.profiles.active=product,可以通过环境变量PROFILE修改
```shell
docker run -d \
    -p 8080:8080 \
    -v /datadisk/myapp/app.jar:/app/app.jar:ro \
    -e TYPE="spring" \
    --name appName \
    --restart always \
    sorc/boothelper:11-jdk
```

### 启动一个quarks项目(jar方式启动)
>需要将编译的target/quarkus-app目录下的文件复制到/datadisk/myapp目录.
>自定义配置文件放在config目录，默认-Dquarkus=prod,可以通过环境变量PROFILE修改
```shell
docker run -d \
    -p 8080:8080 \
    -v /datadisk/myapp:/app \
    -e TYPE="quarks" \
    --name appName \
    --restart always \
    sorc/boothelper:11-jdk
```

### 启动一个java程序(jar方式启动)
需要将编译的jar复制到/datadisk/myapp/app.jar
```shell
docker run -d \
    -p 8080:8080 \
    -v /datadisk/myapp/app.jar:/app/app.jar:ro \
    --name appName \
    --restart always \
    sorc/boothelper:8-jdk
```
### 其他环境变量参数
* RUNCMD 运行成程序或命令 type为none时不在后面追加启动java程序的命令
* VM_ARGS 添加java vm参数 -Dxx.xx=aa
* RUN_ARGS 添加程序运行参数 
### 进行网络测试
内部安装有常用的网络测试工具：curl wget telnet dnsutils traceroute net-tools sysstat tcpdump netcat mtr-tiny nmap
```shell
#更小巧
docker run -it --rm sorc/netool \bin\bash
#如果已经有sorc/boothelper镜像就直接使用
docker run -it --rm sorc/boothelper \bin\bash
```


```shell
#docker-entrypoint.sh
#程序入口命令
#!/bin/bash
echo "VERSION: ${VERSION}"
echo "RUNCMD: ${RUNCMD}"
echo "VM_ARGS: ${VM_ARGS}"
echo "RUN_ARGS: ${RUN_ARGS}"
echo "TYPE: ${TYPE}"
echo "PROFILE: ${PROFILE}"
if [ ! -f "/app/app.jar" ];then
  echo "use default app.jar"
  cp -rf /opt/app/app.jar /app/app.jar
fi
if [ ! -f "/app/install/installed" ];then
  if [ -f "/app/install/install.sh" ];then
    echo "exec /app/install/install.sh"
    chmod +x /app/install/*.sh
    /app/install/install.sh
    echo `date +"%Y-%m-%d %H:%M:%S"` > /app/install/installed
  fi
fi
if [ "${TYPE}" == "none" ];then
  ${RUNCMD} ${RUN_ARGS}
elif [ "${TYPE}" == "spring" ];then
  echo "boot spring ... product"
  if [ -z "${PROFILE}" ];then
    PROFILE="product"
  fi
  ${RUNCMD} java ${VM_ARGS} -Dspring.profiles.active=${PROFILE} -Djava.security.egd=file:/dev/./urandom -jar /app/app.jar ${RUN_ARGS}
elif [ "${TYPE}" == "quarks" ];then
  if [ -z "${PROFILE}" ];then
    PROFILE="prod"
  fi
  echo "boot quarkus ..."
  ${RUNCMD} java ${VM_ARGS} -Dquarkus=${PROFILE} -Djava.security.egd=file:/dev/./urandom -jar /app/quarkus-run.jar ${RUN_ARGS}
else
  echo "boot java ..."
  ${RUNCMD} java ${VM_ARGS} -Djava.security.egd=file:/dev/./urandom -jar /app/app.jar ${RUN_ARGS}
fi


```