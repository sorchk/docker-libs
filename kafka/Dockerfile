ARG JAVA_VER
FROM openjdk:${JAVA_VER}
MAINTAINER sorc@qq.com
ENV SASL_AUTH="false"
ARG VER
ADD kafka_${VER}.tgz /tmp/
COPY kafka/ /tmp/kafka_${VER}/
RUN mkdir -p /kafka/config.bak && \
    mv /tmp/kafka_${VER}/* /kafka/ && \
    sed -i 's#/tmp/kafka-logs#/kafka/kafka-logs#g' /kafka/config/server.properties  && \
    sed -i 's#/tmp/kraft-combined-logs#/kafka/kraft-combined-logs#g' /kafka/config/kraft/server.properties && \
    cp /kafka/config/kraft/server.properties /kafka/config/kraft/sasl_server.properties && \
    sed -i 's#=PLAINTEXT#=SASL_PLAINTEXT#g' /kafka/config/kraft/sasl_server.properties  && \
    echo '# security.inter.broker.protocol=SASL_PLAINTEXT' >> /kafka/config/kraft/sasl_server.properties  && \
    echo 'sasl.mechanism.inter.broker.protocol=SCRAM-SHA-256' >> /kafka/config/kraft/sasl_server.properties  && \
    echo 'sasl.enabled.mechanisms=SCRAM-SHA-256,PLAIN' >> /kafka/config/kraft/sasl_server.properties  && \
    echo 'allow.everyone.if.no.acl.found=false' >> /kafka/config/kraft/sasl_server.properties  && \
    echo 'super.users=User:admin;' >> /kafka/config/kraft/sasl_server.properties  && \
    echo '# authorizer.class.name=kafka.security.authorizer.AclAuthorizer' >> /kafka/config/kraft/sasl_server.properties  && \
    cp -rf /kafka/config/* /kafka/config.bak/ && \
    chmod +x /kafka/docker-entrypoint.sh && \
    chmod +x /kafka/bin/*.sh && \
    rm -rf /kafka/bin/windows && \
    rm -rf /kafka/site-docs

VOLUME ["/kafka/config","/kafka/logs","/kafka/kafka-logs","/kafka/kraft-combined-logs"]
EXPOSE 9092 9093
CMD ["/kafka/docker-entrypoint.sh"]
