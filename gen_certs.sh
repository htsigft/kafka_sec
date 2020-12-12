#!/bin/bash
export SRVPASS=password
export CLIPASS=password

echo "generate broker keystore: "
keytool -keystore kafka.server.keystore.jks -alias broker -keyalg RSA -validity 365 -genkey -storepass $SRVPASS -keypass $SRVPASS -storetype pkcs12 -dname "CN=broker"

echo "creating CA"
openssl req -new -newkey rsa:4096 -days 365 -x509 -subj "/CN=Kafka-CA" -keyout ca-key -out ca-cert -nodes

echo "create client truststore and add CA certyficate"
keytool -keystore kafka.client.truststore.jks -alias CARoot -importcert -file ca-cert -storepass $CLIPASS -keypass $CLIPASS -noprompt

echo "create server truststore and add CA certyficate"
keytool -keystore kafka.server.truststore.jks -alias CARoot -importcert -file ca-cert -storepass $SRVPASS -keypass $SRVPASS -noprompt

echo "export broker certyfikates from keystore (create CSR)"
keytool -keystore kafka.server.keystore.jks -alias broker -certreq -file cert-file -storepass $SRVPASS -keypass $SRVPASS

echo "sign broker certificate"
openssl x509 -req -CA ca-cert -CAkey ca-key -in cert-file -out cert-signed -days 365 -CAcreateserial -passin pass:$SRVPASS

echo "import CA and broker signed certificate to broker keystore"
keytool -keystore kafka.server.keystore.jks -alias CARoot -import -file ca-cert -storepass $SRVPASS -keypass $SRVPASS -noprompt
keytool -keystore kafka.server.keystore.jks -alias broker -import -file cert-signed -storepass $SRVPASS -keypass $SRVPASS

echo "generate client keystore"
keytool -genkey -keystore kafka.client.keystore.jks -validity 365 -storepass $CLIPASS -keypass $CLIPASS -dname "CN=kafkaClient" -alias kafkaClient -storetype pkcs12

echo "export client certificate from keystore (create CSR)"
keytool -keystore kafka.client.keystore.jks -certreq -file client-cert-file -alias kafkaClient -storepass $CLIPASS -keypass $CLIPASS

echo "sign client certificate by CA"
openssl x509 -req -CA ca-cert -CAkey ca-key -in ./client-cert-file -out ./client-cert-signed -days 365 -CAcreateserial -passin pass:serversecret

echo "import CA and client certificate to client keystore"
keytool -keystore kafka.client.keystore.jks -alias CARoot -import -file ./ca-cert -storepass $CLIPASS -keypass $CLIPASS -noprompt
keytool -keystore kafka.client.keystore.jks -import -file client-cert-signed -alias kafkaClient -storepass $CLIPASS -keypass $CLIPASS -noprompt
