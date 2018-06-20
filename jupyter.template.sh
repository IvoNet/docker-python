#!/usr/bin/env bash

PORT=8888
docker run --rm --name jupyter -p ${PORT}:${PORT} -v "$(pwd):/project" ivonet/py3 jupyter notebook --port=${PORT} --ip=0.0.0.0 --allow-root