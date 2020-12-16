source common/variables.sh

source common/docker-clear-containers.sh

docker image rm gft-bigdata/kdc-kadmin

docker image rm gft-bigdata/kerberos-client

docker image rm gft-bigdata/kafka-broker-kerberos

docker image rm gft-bigdata/kafka-client-kerberos

docker image rm gft-bigdata/zookeeper-kerberos

rm -r data

mkdir data

sh ./common/build-container.sh kdc-kadmin

sh ./common/build-container.sh kerberos-client

sh ./common/build-container.sh kafka-broker-kerberos

sh ./common/build-container.sh kafka-client-kerberos

sh ./common/build-container.sh zookeeper-kerberos

docker-compose -f docker-compose-kerberos.yml up