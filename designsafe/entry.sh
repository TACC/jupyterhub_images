#!/bin/bash


if [ ! -d "/home/jupyter/mydata/virtualenvs" ]; then
#    cp -r /home/jupyter/virtualenvs /home/jupyter/mydata/

    echo "creating virtualenvs directory."
    mkdir -p /home/jupyter/mydata/virtualenvs

    echo "creating py2 virtualenv"
    # create py2 virtualenv
    cd /home/jupyter/mydata/virtualenvs && virtualenv -p /usr/bin/python2 py2
    . /home/jupyter/mydata/virtualenvs/py2/bin/activate && pip install ipykernel && deactivate;

    # create py3 virtualenv
    echo "creating py3 virtualenv"
    export LD_LIBRARY_PATH=/opt/conda/lib
    cd /home/jupyter/mydata/virtualenvs && virtualenv -p /opt/conda/bin/python3 py3
    . /home/jupyter/mydata/virtualenvs/py3/bin/activate && pip install ipykernel && deactivate;

fi


# start jupyter
cd /home/jupyter && /usr/local/bin/start-singleuser.sh