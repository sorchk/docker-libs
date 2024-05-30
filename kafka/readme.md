
```shell

# 同时启用SCRAM和PLAIN机制
sasl.enabled.mechanisms=SCRAM-SHA-256,PLAIN
# 为broker间通讯开启SCRAM机制，采用SCRAM-SHA-512算法
sasl.mechanism.inter.broker.protocol=SCRAM-SHA-256
# broker间通讯使用PLAINTEXT
security.inter.broker.protocol=SASL_PLAINTEXT
#ACL配置
allow.everyone.if.no.acl.found=false
# 系统用户,多个分号隔开
super.users=User:admin;
authorizer.class.name=kafka.security.authorizer.AclAuthorizer

# producer.conf
security.protocol=SASL_PLAINTEXT
sasl.mechanism=SCRAM-SHA-256
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="admin" password="admin";

#producer-sa.conf
security.protocol=SASL_PLAINTEXT
sasl.mechanism=SCRAM-SHA-256
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="sa" password="admin!1231qaz";

#授权sa用户访问可以向test主题发送消息
bin/kafka-acls.sh --authorizer-properties --bootstrap-server localhost:9093 --add --allow-principal User:sa --operation Write --topic 'test'
#发送消息
bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic test --producer.config config/producer-sa.conf

#消费消息
/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test group-id=test


/kafka/bin/kafka-acls.sh --authorizer-properties zookeeper.connect=localhost:2181 --add --operation IdempotentWrite --allow-principal User:* --allow-host=* --cluster

/kafka/bin/kafka-acls.sh --authorizer-properties zookeeper.connect=localhost:2181 --add --operation All --allow-principal User:* --allow-host=* --transactional-id=*

/kafka/bin/kafka-acls.sh --authorizer-properties zookeeper.connect=localhost:2181 --add --operation All --allow-principal User:* --allow-host=* --cluster

/kafka/bin/kafka-acls.sh --authorizer-properties zookeeper.connect=localhost:2181 --add --allow-principal User:* --allow-host=* --operation All --group=*  --topic test

/kafka/bin/kafka-acls.sh --authorizer-properties zookeeper.connect=localhost:2181 --add --allow-principal User:* --allow-host=* --operation All --group=*  --topic __consumer_offsets


```
