#!/bin/bash
echo "Kafka version: $VERSION"
echo "$SASL_AUTH"
if [ ! -f "/kafka/config/kraft/server.properties" ];then
  echo "kafka config is not exist, init config..."
  cp -rf /kafka/config.bak/* /kafka/config/
fi
if [ ! -f "/kafka/kraft-combined-logs/meta.properties" ];then
  echo "create cluster id..."
  CLUSTER_ID=$(/kafka/bin/kafka-storage.sh random-uuid) && \
   /kafka/bin/kafka-storage.sh format -t $CLUSTER_ID -c /kafka/config/kraft/server.properties  && \
  echo "cluster id is $CLUSTER_ID"
fi
echo "start kafka..."
if [ "$SASL_AUTH" == "true" ];then
  echo "SASL is enabled"
  if [ ! -f "/kafka/config/jaas.config" ];then
    echo "jaas.config is not exist, init config..."
    cp /kafka/config.bak/jaas.config /kafka/config/jaas.config
  fi
  if [ ! -f "/kafka/config/kraft/sasl_server.properties" ];then
    echo "kraft/sasl_server.properties is not exist, init config..."
    cp /kafka/config.bak/kraft/sasl_server.properties /kafka/config/kraft/sasl_server.properties
  fi
  export KAFKA_OPTS="$KAFKA_OPTS -Djava.security.auth.login.config=/kafka/config/jaas.config"
  /kafka/bin/kafka-server-start.sh /kafka/config/kraft/sasl_server.properties
else
  echo "SASL is disabled"
  /kafka/bin/kafka-server-start.sh /kafka/config/kraft/server.properties
fi


