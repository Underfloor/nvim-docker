#!/bin/bash

docker build --no-cache -t nvim .
rm nvim-docker.tar
docker save nvim > nvim-docker.tar
./docker-install.sh
