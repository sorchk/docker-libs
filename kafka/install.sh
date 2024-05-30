tar -vxf kafka_2.13-3.2.0.tgz
cd kafka_2.13-3.2.0
./bin/kafka-storage.sh random-uuid
./bin/kafka-storage.sh format -t WE5TbtDbQZmn2qQ2kHawOA -c ./config/kraft/server.properties
./bin/kafka-server-start.sh ./config/kraft/server.properties


docker build -t sorc/kafka:deb_10_2.13-3.2.0 ./
docker tag sorc/kafka:deb_10_2.13-3.2.0 sorc/kafka:latest

docker run -d \
    -p 9092:9092 \
    -p 9093:9093 \
    -e TZ="Asia/Shanghai" \
    -e SASL_AUTH="true" \
    -v /etc/localtime:/etc/localtime:ro \
    -v /datadisk/kafka/config:/kafka/config \
    -v /datadisk/kafka/logs:/kafka/logs \
    -v /datadisk/kafka/kraft-combined-logs:/kafka/kraft-combined-logs \
    --restart always \
    --name kafka \
    sorc/kafka:deb_10_2.13-3.2.0

export KAFKA_OPTS="$KAFKA_OPTS -Djava.security.auth.login.config=/kafka/config/jaas.config"
echo $KAFKA_OPTS
/kafka/bin/kafka-console-consumer.sh  --bootstrap-server localhost:9092 --topic test --from-beginning --consumer-property security.protocol=SASL_PLAINTEXT sasl.mechanism=PLAIN

