#!/bin/bash

cp /etc/scripts/kafka_server_jaas.conf /etc/kafka/secrets/kafka_server_jaas.conf

chmod 777 /etc/kafka/secrets/kafka_server_jaas.conf

source /etc/confluent/docker/run