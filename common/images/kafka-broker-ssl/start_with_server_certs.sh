#!/bin/bash
export SRVPASS=password
export CLIPASS=password

echo "create directory: /etc/kafka/secrets/ssl"
mkdir -p "/etc/kafka/secrets/ssl"

echo "move to directory: /etc/kafka/secrets/ssl"
cd /etc/kafka/secrets/ssl

echo "generate broker keystore: "
keytool -genkey -keystore kafka.server.keystore.jks -alias broker -keyalg RSA -validity 365 -storepass $SRVPASS -keypass $SRVPASS -storetype pkcs12 -dname "CN=broker"

echo "creating CA"
openssl req -new -newkey rsa:4096 -days 365 -x509 -subj "/CN=Kafka-CA" -keyout ca-key -out ca-cert -nodes

echo "create server truststore and add CA certyficate"
keytool -keystore kafka.server.truststore.jks -alias CARoot -importcert -file ca-cert -storepass $SRVPASS -keypass $SRVPASS -noprompt

echo "export broker certificates from keystore (create CSR)"
keytool -keystore kafka.server.keystore.jks -alias broker -certreq -file cert-file -storepass $SRVPASS -keypass $SRVPASS

echo "sign broker certificate"
openssl x509 -req -CA ca-cert -CAkey ca-key -in cert-file -out cert-signed -days 365 -CAcreateserial -passin pass:$SRVPASS

echo "import CA and broker signed certificate to broker keystore"
keytool -keystore kafka.server.keystore.jks -alias CARoot -import -file ca-cert -storepass $SRVPASS -keypass $SRVPASS -noprompt
keytool -keystore kafka.server.keystore.jks -alias broker -import -file cert-signed -storepass $SRVPASS -keypass $SRVPASS

echo "folder:"
pwd

echo "folder contents:"
ls -al

echo $SRVPASS > broker_ssl_creds
echo $SRVPASS > broker_keystore_creds
echo $SRVPASS > broker_truststore_creds

source /etc/confluent/docker/run