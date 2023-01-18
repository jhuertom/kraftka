#!/usr/bin/env bash
# Based on https://github.com/bashj79/kafka-kraft-docker

if [[ -z "$KAFKA_PROCESS_ROLES" ]]; then
    echo 'Using default process roles'
else
    echo "Using process roles: ${KAFKA_PROCESS_ROLES}"
    sed -r -i "s@^#?process.roles=.*@process.roles=$KAFKA_PROCESS_ROLES@g" "/opt/kafka/config/kraft/server.properties"
fi

if [[ -z "$KAFKA_NODE_ID" ]]; then
    echo 'Using default node id'
else
    echo "Using node id: ${KAFKA_NODE_ID}"
    sed -r -i "s@^#?node.id=.*@node.id=$KAFKA_NODE_ID@g" "/opt/kafka/config/kraft/server.properties"
fi

if [[ -z "$KAFKA_CONTROLLER_QUORUM_VOTERS" ]]; then
    echo 'Using default controller quorum voters'
else
    echo "Using controller quorum voters: ${KAFKA_CONTROLLER_QUORUM_VOTERS}"
    sed -r -i "s~^#?controller.quorum.voters=.*~controller.quorum.voters=$KAFKA_CONTROLLER_QUORUM_VOTERS~g" "/opt/kafka/config/kraft/server.properties"
fi

if [[ -z "$KAFKA_LISTENERS" ]]; then
    echo 'Using default listeners'
else
    echo "Using listeners: ${KAFKA_LISTENERS}"
    sed -r -i "s@^#?listeners=.*@listeners=$KAFKA_LISTENERS@g" "/opt/kafka/config/kraft/server.properties"
fi

if [[ -z "$KAFKA_ADVERTISED_LISTENERS" ]]; then
    echo 'Using default advertised listeners'
else
    echo "Using advertised listeners: ${KAFKA_ADVERTISED_LISTENERS}"
    sed -r -i "s@^#?advertised.listeners=.*@advertised.listeners=$KAFKA_ADVERTISED_LISTENERS@g" "/opt/kafka/config/kraft/server.properties"
fi

if [[ -z "$KAFKA_LISTENER_SECURITY_PROTOCOL_MAP" ]]; then
    echo 'Using default listener security protocol map'
else
    echo "Using listener security protocol map: ${KAFKA_LISTENER_SECURITY_PROTOCOL_MAP}"
    sed -r -i "s@^#?listener.security.protocol.map=.*@listener.security.protocol.map=$KAFKA_LISTENER_SECURITY_PROTOCOL_MAP@g" "/opt/kafka/config/kraft/server.properties"
fi

if [[ -z "$KAFKA_INTER_BROKER_LISTENER_NAME" ]]; then
    echo 'Using default inter broker listener name'
else
    echo "Using inter broker listener name: ${KAFKA_INTER_BROKER_LISTENER_NAME}"
    sed -r -i "s@^#?inter.broker.listener.name=.*@inter.broker.listener.name=$KAFKA_INTER_BROKER_LISTENER_NAME@g" "/opt/kafka/config/kraft/server.properties"
fi

if [[ -z "$KAFKA_UUID" ]]; then
    echo "New KAFKA_UUID generated:"
    /opt/kafka/bin/kafka-storage.sh random-uuid
    echo "Please, copy the new UUID and set it in the environment variable KAFKA_UUID before restarting the container."
else
    /opt/kafka/bin/kafka-storage.sh format -t $KAFKA_UUID -c /opt/kafka/config/kraft/server.properties
    /opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/kraft/server.properties
fi