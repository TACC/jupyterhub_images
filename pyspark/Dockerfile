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

RUN pip2 install -e git+https://github.com/TACC/agavepy.git#egg=agavepy

EXPOSE 8888

ADD singleuser.sh /srv/singleuser/singleuser.sh
CMD ["sh", "/srv/singleuser/singleuser.sh"]
