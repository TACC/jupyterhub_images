# Image: taccsciapps/jupyteruser-ds
# This image is built to run on the JupyterHub. In order to run it locally, you need to provide a config file and a
# separate command, e.g.
# docker run --rm -p 8889:8888 -v jupyter-notebook-localconf.py:/home/jupyter/.jupyter/jupyter_notebook_config.py taccsciapps/jupyteruser-ds start-notebook.sh

FROM jupyter/scipy-notebook
MAINTAINER Joe Stubbs <jstubbs@tacc.utexas.edu>

USER root
RUN apt-get update
RUN apt-get install -y libxrender1
RUN easy_install virtualenv

# ------------------
# additional kernels
# ------------------
# bash
RUN pip install bash_kernel
RUN python -m bash_kernel.install

# metakernel
RUN pip install metakernel

# R kernel
RUN apt-get install -y r-base r-recommended
RUN conda install -c r r-essentials
RUN conda install --quiet -c r "r-base=3.3.1 1"


# add jupyter user mapped to special uid
RUN groupadd --gid 816877 G-816877
RUN adduser --uid 458981 --ingroup G-816877 --home /home/jupyter --shell /bin/bash jupyter

USER jupyter
ENV HOME /home/jupyter
ENV SHELL /bin/bash
ENV USER jupyter


USER root
WORKDIR /root
RUN apt-get -y install subversion emacs make tcl8.5 tcl8.5-dev gcc g++ gfortran mpich2 ssh curl gnuplot


# RUN mkdir -p /opt/conda/share/jupyter/kernels/python2_venv
ADD py2_venv_kernel.json /opt/conda/share/jupyter/kernels/python2_venv/kernel.json

WORKDIR /home/jupyter/

# allow users to add kernels
RUN chmod 777 /opt/conda/share/jupyter/kernels


# -------
# DS Apps
# -------

# opensees
COPY ./OpenSees-deb-2.5.0.6482 /usr/local/bin/OpenSees
RUN chmod 755 /usr/local/bin/OpenSees

# matlab
#WORKDIR /root/
#COPY matlab_R2016a_glnxa64.zip /root/matlab_R2016a_glnxa64.zip
#RUN unzip matlab_R2016a_glnxa64.zip
#COPY installer_input.txt /root/installer_input.txt
#RUN /root/install -mode silent -installFile=/root/installer_input.txt -agreeToLicense yes -fileInstallationKey 53952-15089-42733-40066-52797-59907-27345-46331-25342-08418-58926


RUN pip install SIP
#RUN apt-get install -y libxml2 libxml2-dev libxslt1-dev python-lxml python-numexpr
RUN apt-get update
RUN apt-get install -y libxml2 libxml2-dev libxslt1-dev python-lxml python-matplotlib python-numpy python-scipy python-numexpr python-qt4 pyqt4-dev-tools python3-pyqt4
RUN pip install ObsPy
RUN echo "allowed_users=anybody" > /etc/X11/Xwrapper.config


# -----------
# Agave tools
# -----------
USER root 
# install agavepy

RUN pip2 install agavepy ObsPy plotly

# -----------
# GeoClaw / Clawpack
# -----------
RUN pip install --src=/home/jupyter/util/ --user -e git+https://github.com/clawpack/clawpack.git@v5.4.0#egg=clawpack-v5.4.0
WORKDIR /home/jupyter/util/clawpack-v5.4.0
RUN python setup.py install
USER jupyter
ENV CLAW=/home/jupyter/util/clawpack-v5.4.0
ENV FC=gfortran

# install CLI
USER jupyter
WORKDIR /home/jupyter/
RUN git clone https://bitbucket.org/agaveapi/cli.git
ENV PATH=$PATH:$HOME/cli/bin

# examples
USER jupyter
RUN mkdir -p /home/jupyter/util
ADD agavepy_example.ipynb /home/jupyter/util/agavepy_example.ipynb
ADD opensees-submit-example.ipynb /home/jupyter/util/opensees-submit-example.ipynb

# startx and README
RUN startx &
RUN echo "Welcome to the DesignSafe-ci JupyterHub terminal. Your DesignSafe-ci home directory is in 'mydata.' Any files you wish to save between sessions must be within that directory. OpenSees is availavble to run interactively here. " > /home/jupyter/README.txt
RUN echo "0949f6ce05b1" > /home/jupyter/.imageID
COPY rbnb.jar /home/jupyter/util/rbnb.jar

# create the python3 kernel and virtualenv
RUN mkdir -p /opt/conda/share/jupyter/kernels/python3_venv
ADD py3_venv_kernel.json /opt/conda/share/jupyter/kernels/python3_venv/kernel.json

# custom entrypoint to bootstrap the image
USER root
RUN rm -rf /opt/conda/share/jupyter/kernels/python2_venv
RUN rm -rf /opt/conda/share/jupyter/kernels/python3_venv
ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

CMD ["sh", "/entry.sh"]

ADD start-singleuser.sh /usr/local/bin/start-singleuser.sh
RUN chmod 0775 /usr/local/bin/start-singleuser.sh

RUN chown -R jupyter: /home/jupyter/util

USER jupyter

