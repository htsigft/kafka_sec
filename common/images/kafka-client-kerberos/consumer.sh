#!/bin/bash

kafka-console-consumer --topic bar --from-beginning --bootstrap-server broker:9093 --consumer.config /etc/scripts/security.properties