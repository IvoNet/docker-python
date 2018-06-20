#!/usr/bin/env bash

PORT=8888
docker run --rm -p ${PORT}:8888 -e "$(pwd):/project" ivonet/jupyter $*