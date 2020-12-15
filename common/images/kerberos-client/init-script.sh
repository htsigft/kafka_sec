#!/bin/bash

source `dirname $0`/configureKerberosClient.sh

kadminCommand "add_principal -nokey kafka/broker@GFT.COM"

kadminCommand "ktadd -k /etc/security/keytabs/kafka_server.keytab kafka/broker@GFT.COM"

kadminCommand "add_principal -nokey kafka/broker.kafka_sec_default@GFT.COM"

kadminCommand "ktadd -k /etc/security/keytabs/kafka_server.keytab kafka/broker.kafka_sec_default@GFT.COM"

kadminCommand "add_principal -nokey kafka_client/kdc-kadmin@GFT.COM"

kadminCommand "ktadd -k /etc/security/keytabs/kafka_client.keytab kafka_client/kdc-kadmin@GFT.COM"

kadminCommand "add_principal -nokey zookeeper/zookeeper.kafka_sec_default@GFT.COM"

kadminCommand "ktadd -k /etc/security/keytabs/zookeeper.keytab zookeeper/zookeeper.kafka_sec_default@GFT.COM"