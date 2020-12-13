CALL common/variables.bat

CALL common/docker-clear-containers.bat

cd common/images/kafka-broker-ssl

CALL build.bat

cd ../kafka-client-ssl

CALL build.bat

cd ../../../

docker-compose -f docker-compose.yml up