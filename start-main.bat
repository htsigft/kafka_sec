CALL common/variables.bat

CALL common/docker-clear-containers.bat

docker image rm gft-bigdata/kafka-broker-ssl

docker image rm gft-bigdata/kafka-client-ssl

rm /S "data"

mkdir "data"

cd common/images/kafka-broker-ssl

CALL build.bat

cd ../kafka-client-ssl

CALL build.bat

cd ../../../

docker-compose -f docker-compose.yml up