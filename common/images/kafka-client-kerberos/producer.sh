#!/bin/bash

kafka-console-producer --broker-list broker:9093 --topic bar --producer.config /etc/scripts/security.properties