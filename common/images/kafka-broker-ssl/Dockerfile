FROM confluentinc/cp-server:6.0.0

USER root

COPY gen_server_certs.sh /etc/scripts/gen_certs.sh

RUN mkdir "/etc/kafka/secrets/ssl"

RUN chmod 777 /etc/scripts/gen_certs.sh

RUN /etc/scripts/gen_certs.sh

CMD ["/etc/confluent/docker/run"]