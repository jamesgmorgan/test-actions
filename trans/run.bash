#!/bin/bash -ex

docker image ls 2>&1

time docker build -t trans . 2>&1
docker run --rm trans ls -l /usr/include/urdf_parser 2>&1

docker image ls 2>&1
