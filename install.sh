#!/usr/bin/env bash

OVERRIDE=1
ClEAN_STATE=1 # Removes existing docker states (containers) if set to 1

create_run_script() {
    sed "s/CONTAINER/$1/g" run.template.sh > ~/bin/$1
    chmod +x ~/bin/$1
}

clean_state() {
    if [ $ClEAN_STATE == 1 ]; then
        if [ "$(docker ps -q -f name=$1)" ]; then
                echo "Remove running and existing container..."
                docker stop $1
                docker rm $1
        else
            if [ "$(docker ps -aq -f status=exited -f name=$1)" ]; then
                echo "Remove existing container..."
                docker rm $1
            fi
        fi
    fi
}
build_it() {
    sed "s/VERSION/$1/g" Dockerfile.template > Dockerfile
#    sed -i "" "s/INTERPRETER/$3/g" Dockerfile
    cat Dockerfile
    docker build -t ivonet/$2 .
    if [ $OVERRIDE == 0 ]; then
        if [ -f ~/bin/$2 ]; then
            echo "Could not create executable ~/bin/$2 as it already exists"
        else
            create_run_script $2
        fi
    else
        create_run_script $2
    fi
    rm -f Dockerfile 2>/dev/null
    clean_state $2
}

build_it 3.6.5-jessie py3
#build_it 3.6.5-alpine3.7 python3.6.5 python3

#docker rmi $(docker images -q -f dangling=true)
