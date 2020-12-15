@echo off

CALL ../../kerberos-env.bat

docker build -t gft-bigdata/kdc-kadmin .