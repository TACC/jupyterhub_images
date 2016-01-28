# Image: jstubbs/jupyter-pyspark

FROM jupyter/pyspark-notebook
MAINTAINER Joe Stubbs <jstubbs@tacc.utexas.edu>

RUN apt-get update
RUN apt-get install -y libxrender1

# fetch juptyerhub-singleuser entrypoint
ADD https://raw.githubusercontent.com/jupyter/jupyterhub/master/jupyterhub/singleuser.py /usr/local/bin/jupyterhub-singleuser
RUN chmod 755 /usr/local/bin/jupyterhub-singleuser

# jupyter is our user
RUN useradd -m -s /bin/bash jupyter

USER jupyter
ENV HOME /home/jupyter
ENV SHELL /bin/bash
ENV USER jupyter

WORKDIR /home/jupyter/

USER root
RUN /opt/conda/envs/python2/bin/pip install -e git+https://github.com/TACC/agavepy.git#egg=agavepy

EXPOSE 8888

USER jupyter
RUN mkdir -p /home/jupyter/examples
ADD cosine_distance.svg /home/jupyter/examples/cosine_distance.svg
ADD agavepy_example.ipynb /home/jupyter/examples/agavepy_example.ipynb
ADD pyspark_genome_example.ipynb /home/jupyter/examples/pyspark_genome_example.ipynb

USER root
RUN chown -R jupyter:jupyter /home/jupyter/examples

USER jupyter
ADD singleuser.sh /srv/singleuser/singleuser.sh
CMD ["sh", "/srv/singleuser/singleuser.sh"]
