CALL common/variables.bat

CALL common/docker-clear-containers.bat

docker image rm gft-bigdata/kdc-kadmin

docker image rm gft-bigdata/kerberos-client

docker image rm gft-bigdata/kafka-broker-kerberos

docker image rm gft-bigdata/kafka-client-kerberos

docker image rm gft-bigdata/zookeeper-kerberos

rm /S "data"

mkdir "data"

CALL common/build-container.bat kdc-kadmin

CALL common/build-container.bat kerberos-client

CALL common/build-container.bat kafka-broker-kerberos

CALL common/build-container.bat kafka-client-kerberos

CALL common/build-container.bat zookeeper-kerberos

docker-compose -f docker-compose-kerberos.yml up