CALL common/variables.bat

CALL common/docker-clear-containers.bat

docker image rm gft-bigdata/kafka-broker-ssl

docker image rm gft-bigdata/kafka-client-ssl

rm /S "data"

mkdir "data"

CALL common/build-container.sh kafka-broker-ssl

CALL common/build-container.sh kafka-client-ssl

docker-compose -f docker-compose.yml up