FROM confluentinc/cp-server:6.0.0

USER root

COPY gen_client_certs.sh /etc/scripts/gen_certs.sh

RUN chmod 777 /etc/scripts/gen_certs.sh

COPY ssl.properties /bin/ssl.properties

RUN chmod 777 /bin/ssl.properties

CMD ["/etc/scripts/gen_certs.sh"]