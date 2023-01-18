
FROM alpine:3.14 AS builder

ENV KAFKA_VERSION=3.3.1
ENV SCALA_VERSION=2.13

RUN apk update && apk add --no-cache bash openjdk8
COPY kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz /tmp/
RUN tar -xzf /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt && \
    rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    mv /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka
COPY start_kafka.sh /bin/
RUN chmod +x /bin/start_kafka.sh

ENV PATH="/usr/lib/jvm/java-8-openjdk/bin/:/opt/kafka/bin/:$PATH"
CMD [ "/bin/start_kafka.sh" ]
