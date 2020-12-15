source common/variables.sh

source common/docker-clear-containers.sh

docker image rm gft-bigdata/kafka-broker-ssl

docker image rm gft-bigdata/kafka-client-ssl

rm -r data

mkdir data

cd common/images/kafka-broker-ssl

source build.sh

cd ../kafka-client-ssl

source build.sh

cd ../../../

docker-compose -f docker-compose-ssl-anc.yml up