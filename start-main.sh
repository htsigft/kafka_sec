source common/variables.sh

source common/docker-clear-containers.sh

docker image rm gft-bigdata/kafka-broker-ssl

docker image rm gft-bigdata/kafka-client-ssl

rm -r data

mkdir data

source common/build-container.sh kafka-broker-ssl

source common/build-container.sh kafka-client-ssl

docker-compose -f docker-compose-kerberos.yml up