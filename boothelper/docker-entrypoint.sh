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
  echo "boot spring ... ${PROFILE}"
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

