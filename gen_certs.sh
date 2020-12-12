#!/bin/bash
export SRVPASS=password
export CLIPASS=password

# generate broker keystore
keytool -keystore kafka.server.keystore.jks -alias broker -keyalg RSA -validity 365 -genkey -storepass $SRVPASS -keypass $SRVPASS -storetype pkcs12 -dname "CN=broker"

# creating CA
openssl req -new -newkey rsa:4096 -days 365 -x509 -subj "/CN=Kafka-CA" -keyout ca-key -out ca-cert -nodes

# create client truststore and add CA certyficate
keytool -keystore kafka.client.truststore.jks -alias CARoot -importcert -file ca-cert -storepass $CLIPASS -keypass $CLIPASS -noprompt

# create server truststore and add CA certyficate
keytool -keystore kafka.server.truststore.jks -alias CARoot -importcert -file ca-cert -storepass $SRVPASS -keypass $SRVPASS -noprompt

# export broker certyfikates from keystore (create CSR)
keytool -keystore kafka.server.keystore.jks -alias broker -certreq -file cert-file -storepass $SRVPASS -keypass $SRVPASS

# sign broker certificate
openssl x509 -req -CA ca-cert -CAkey ca-key -in cert-file -out cert-signed -days 365 -CAcreateserial -passin pass:$SRVPASS

# import CA and broker signed certificate to broker keystore
keytool -keystore kafka.server.keystore.jks -alias CARoot -import -file ca-cert -storepass $SRVPASS -keypass $SRVPASS -noprompt
keytool -keystore kafka.server.keystore.jks -alias broker -import -file cert-signed -storepass $SRVPASS -keypass $SRVPASS

# generate client keystore
keytool -genkey -keystore kafka.client.keystore.jks -validity 365 -storepass $CLIPASS -keypass $CLIPASS -dname "CN=kafkaClient" -alias kafkaClient -storetype pkcs12

# export client certificate from keystore (create CSR)
keytool -keystore kafka.client.keystore.jks -certreq -file client-cert-file -alias kafkaClient -storepass $CLIPASS -keypass $CLIPASS

# sign client certificate by CA
openssl x509 -req -CA ca-cert -CAkey ca-key -in ./client-cert-file -out ./client-cert-signed -days 365 -CAcreateserial -passin pass:serversecret

# import CA and client certificate to client keystore
keytool -keystore kafka.client.keystore.jks -alias CARoot -import -file ../ca-cert -storepass $CLIPASS -keypass $CLIPASS -noprompt
keytool -keystore kafka.client.keystore.jks -import -file client-cert-signed -alias kafkaClient -storepass $CLIPASS -keypass $CLIPASS -noprompt
