FROM confluentinc/cp-zookeeper:6.0.0

USER root

COPY zookeeper_jaas.conf /etc/kafka/secrets/zookeeper_jaas.conf

RUN chmod 777 /etc/kafka/secrets/zookeeper_jaas.conf

CMD ["/etc/confluent/docker/run"]