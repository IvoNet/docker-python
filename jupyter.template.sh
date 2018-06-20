#!/usr/bin/env bash

PORT=8888
NAME=jupyter
RUNNING=$(docker inspect --format="{{ .State.Running }}" jupyter 2> /dev/null)

if [ $? -eq 1 ] || [ "$RUNNING" == "false" ]; then
  /usr/bin/osascript -e 'display notification "You might need to refresh the browser..." with title "Jupyter" subtitle "Starting..."'
  docker run --rm -d --name jupyter -p ${PORT}:${PORT} -v "$(pwd):/project" ivonet/py3 jupyter notebook --port=${PORT} --ip=0.0.0.0 --allow-root --no-browser
  open http://localhost:${PORT}
else
  /usr/bin/osascript -e 'display notification "Stopping..." with title "Jupyter"'
  docker stop jupyter
  /usr/bin/osascript -e 'display notification "Stopped successfully." with title "Jupyter"'
fi
