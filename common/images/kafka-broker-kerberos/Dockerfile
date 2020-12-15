FROM confluentinc/cp-server:6.0.0

USER root

COPY kafka_server_jaas.conf /etc/scripts/kafka_server_jaas.conf

RUN chmod 777 /etc/scripts/kafka_server_jaas.conf

COPY start.sh /etc/scripts/start.sh

RUN chmod 777 /etc/scripts/start.sh

CMD ["/etc/scripts/start.sh"]