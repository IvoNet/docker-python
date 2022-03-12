#!/usr/bin/env bash

PORT=8888
NAME=CONTAINER
RUNNING=$(docker inspect --format="{{ .State.Running }}" ${NAME}n 2> /dev/null)

if [ $? -eq 1 ] || [ "$RUNNING" == "false" ]; then
  /usr/bin/osascript -e 'display notification "You might need to refresh the browser..." with title "Jupyter" subtitle "Starting..."'
  docker run --rm -d --name ${NAME}n -p ${PORT}:${PORT} -v "$(pwd):/project" ivonet/${NAME} jupyter notebook --port=${PORT} --allow-root
  open http://localhost:${PORT}
else
  /usr/bin/osascript -e 'display notification "Stopping..." with title "Jupyter"'
  docker stop ${NAME}n
  /usr/bin/osascript -e 'display notification "Stopped successfully." with title "Jupyter"'
fi
