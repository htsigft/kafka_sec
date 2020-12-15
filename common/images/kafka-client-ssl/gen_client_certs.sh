#!/bin/bash
export SRVPASS=password
export CLIPASS=password

echo "create directory: /etc/kafka/secrets/ssl"
mkdir -p "/etc/kafka/secrets/ssl"

echo "move to directory: /etc/kafka/secrets/ssl"
cd /etc/kafka/secrets/ssl

echo "generate client keystore"
keytool -genkey -keystore kafka.client.keystore.jks -alias client -keyalg RSA -validity 365 -storepass $CLIPASS -keypass $CLIPASS -storetype pkcs12 -dname "CN=client"

echo "export client certificate from keystore (create CSR)"
keytool -keystore kafka.client.keystore.jks -alias client -certreq -file client-cert-file -storepass $CLIPASS -keypass $CLIPASS

echo "create client truststore and add CA certyficate"
keytool -keystore kafka.client.truststore.jks -alias CARoot -importcert -file ca-cert -storepass $CLIPASS -keypass $CLIPASS -noprompt
sleep 1
echo "sign client certificate by CA"
openssl x509 -req -CA ca-cert -CAkey ca-key -in client-cert-file -out client-cert-signed -days 365 -CAserial ca-cert.srl -passin pass:$CLIPASS
sleep 1
echo "import CA and client certificate to client keystore"
keytool -keystore kafka.client.keystore.jks -alias CARoot -import -file ca-cert -storepass $CLIPASS -keypass $CLIPASS -noprompt
keytool -keystore kafka.client.keystore.jks -alias client -import -file client-cert-signed  -storepass $CLIPASS -keypass $CLIPASS

sleep "infinity"