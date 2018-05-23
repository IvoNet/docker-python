# Python images

This project contains python versions to play with on your machine

# Install

* run `./install.sh` 
    * to create the images with the different versions installed
    * to install run scripts in you `~/bin` folder
    
# How it works

Well based on the `install.sh` script a couple of python image versions are pulled and customized
through the `Dockerfile.template` file. With the `sed` command this template file is created into a 
`Dockerfile` and build by docker into a `ivonet/py$VERSION` image.
A startup shell script is created for every version created in the `~/bin` folder with the following
naming convention `py$MAJOR_VERSION_NUMBER` e.g. `py3`

During the build the `requirements.txt` file is installed by pip, so you can use this file to prepare the 
python image according to your requirements.

Look into the `install.sh` to see which versions are currently installed.

# Running

The scripts created will run a python container based on the major version and create a 
named container for it. Except from the version these images start out "the same", but
can start varying in their state.

The run script will mount the folder you are currently standing in to the /project folder
in the container, which is the working directory for the image.

# Troubleshooting

It is assumed is that the `~/bin` exists and resides on the front of your PATH.

if this is not the case please edit `~/.profile` or `.bashrc` and add the following line
at the end of this file:

    export PATH=~/bin:$PATH

All should be fine now.