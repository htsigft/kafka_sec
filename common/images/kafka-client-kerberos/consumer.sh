#!/bin/bash

kafka-console-consumer --topic bar --from-beginning --bootstrap-server localhost:9093 --consumer.config /etc/scripts/security.properties