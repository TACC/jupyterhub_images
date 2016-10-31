# Image: jstubbs/jupyter-pyspark
# This container essentially extends jstubbs/jupyter-pyspark

FROM jupyter/pyspark-notebook
MAINTAINER John Fonner <jfonner@tacc.utexas.edu>

USER root
RUN apt-get update && apt-get install -y libxrender1 curl bsdmainutils jq node npm

# fetch juptyerhub-singleuser entrypoint
ADD jupyterhub-singleuser.py /usr/local/bin/jupyterhub-singleuser
RUN chmod 755 /usr/local/bin/jupyterhub-singleuser

# jupyter is our user
RUN useradd -m -s /bin/bash jupyter

USER jupyter
ENV HOME /home/jupyter
ENV SHELL /bin/bash
ENV USER jupyter

WORKDIR /home/jupyter/

# install agavepy
USER root
RUN /opt/conda/envs/python2/bin/pip install -e git+https://github.com/TACC/agavepy.git#egg=agavepy

# install bash kernel
RUN pip install bash_kernel
RUN python -m bash_kernel.install

EXPOSE 8888

# install the Agave CLI tools
USER jupyter
RUN git clone https://bitbucket.org/agaveapi/cli.git
ENV PATH=$PATH:$HOME/cli/bin

RUN mkdir -p /home/jupyter/examples
ADD cosine_distance.svg /home/jupyter/examples/cosine_distance.svg
ADD agavepy_example.ipynb /home/jupyter/examples/agavepy_example.ipynb
ADD pyspark_genome_example.ipynb /home/jupyter/examples/pyspark_genome_example.ipynb

USER root
RUN chown -R jupyter:jupyter /home/jupyter/examples && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    export PATH=/usr/bin:$PATH
    
USER jupyter
ADD singleuser.sh /srv/singleuser/singleuser.sh
CMD ["sh", "/srv/singleuser/singleuser.sh"]
