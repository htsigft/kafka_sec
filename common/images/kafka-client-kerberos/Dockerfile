FROM confluentinc/cp-server:6.0.0

USER root

COPY kafka_client_jaas.conf /etc/scripts/kafka_client_jaas.conf

RUN chmod 777 /etc/scripts/kafka_client_jaas.conf

COPY security.properties /etc/scripts/security.properties

RUN chmod 777 /etc/scripts/security.properties

COPY producer.sh /etc/scripts/producer.sh

RUN chmod 777 /etc/scripts/producer.sh

COPY consumer.sh /etc/scripts/consumer.sh

RUN chmod 777 /etc/scripts/consumer.sh

COPY start.sh /etc/scripts/start.sh

RUN chmod 777 /etc/scripts/start.sh

CMD ["/etc/scripts/start.sh"]