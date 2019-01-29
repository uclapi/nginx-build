#!/bin/bash
docker rm uclapi-nginx-build

docker build -t uclapi-nginx-build .
docker run -it -v `pwd`/builds:/builds --rm uclapi-nginx-build
