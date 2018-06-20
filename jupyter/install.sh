#!/usr/bin/env bash


create_run_script() {
    cp run.template.sh ~/bin/$1
    chmod +x ~/bin/$1
}

docker build -t ivonet/jupyter .

create_run_script jupyter
#create_run_script pynote
create_run_script pyn
