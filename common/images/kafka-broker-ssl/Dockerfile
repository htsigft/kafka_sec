FROM confluentinc/cp-server:6.0.0

USER root

COPY start_with_server_certs.sh /etc/scripts/start.sh

RUN chmod 777 /etc/scripts/start.sh

CMD ["/etc/scripts/start.sh"]