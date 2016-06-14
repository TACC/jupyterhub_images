# Image: taccsciapps/jupyter-pyspark-ds

FROM jupyter/pyspark-notebook
MAINTAINER Joe Stubbs <jstubbs@tacc.utexas.edu>

USER root
RUN apt-get update
RUN apt-get install -y libxrender1

# fetch juptyerhub-singleuser entrypoint
ADD jupyterhub-singleuser.py /usr/local/bin/jupyterhub-singleuser
RUN chmod 755 /usr/local/bin/jupyterhub-singleuser

# jupyter is our user
RUN groupadd --gid 816877 G-816877
RUN adduser --uid 458981 --ingroup G-816877 --home /home/jupyter --shell /bin/bash jupyter

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

# install metakernel
RUN pip install metakernel

EXPOSE 8888

USER jupyter
RUN mkdir -p /home/jupyter/examples
ADD cosine_distance.svg /home/jupyter/examples/cosine_distance.svg
ADD agavepy_example.ipynb /home/jupyter/examples/agavepy_example.ipynb
ADD pyspark_genome_example.ipynb /home/jupyter/examples/pyspark_genome_example.ipynb

USER root
RUN chown -R jupyter:G-816877 /home/jupyter/examples

USER jupyter
ADD singleuser.sh /srv/singleuser/singleuser.sh
CMD ["sh", "/srv/singleuser/singleuser.sh"]

#steve's modifications
USER root
WORKDIR /root
RUN apt-get -y install subversion emacs make tcl8.5 tcl8.5-dev gcc g++ gfortran mpich2 ssh curl gnuplot

WORKDIR /home/jupyter/

#RUN pip install matlab_kernel
#RUN python -m matlab_kernel.install
COPY ./OpenSees-deb /usr/local/bin/OpenSees
RUN chmod 755 /usr/local/bin/OpenSees
# Install R kernel for jupyter
RUN apt-get install -y r-base r-recommended
RUN conda install -c r r-essentials
WORKDIR /root/
COPY matlab_R2016a_glnxa64.zip /root/matlab_R2016a_glnxa64.zip
RUN unzip matlab_R2016a_glnxa64.zip
COPY installer_input.txt /root/installer_input.txt
RUN /root/install -mode silent -installFile=/root/installer_input.txt -agreeToLicense yes -fileInstallationKey 53952-15089-42733-40066-52797-59907-27345-46331-25342-08418-58926
USER jupyter
WORKDIR /home/jupyter
RUN mkdir /home/jupyter/util && cd /home/jupyter/util && git clone https://git@bitbucket.org/taccaci/foundation-cli.git && /home/jupyter/util/foundation-cli/bin/tenants-init -t designsafe
RUN mv examples util
USER root
RUN rm -rf /home/jupyter/src
RUN pip install --upgrade pip
RUN apt-get install -y python-pip python2.7-dev libxext-dev python-qt4 qt4-dev-tools build-essential xfce4
RUN pip install SIP 
#RUN pip install PyQt
#RUN apt-get install -y python-obspy python3-obspy
RUN apt-get install -y libxml2 libxml2-dev libxslt1-dev python-lxml python-matplotlib python-numpy python-scipy python-numexpr
#RUN pip install lxml
RUN pip install ObsPy
#RUN pip2 install lxml 
RUN pip2 install ObsPy
RUN echo "allowed_users=anybody" > /etc/X11/Xwrapper.config
USER jupyter
RUN startx &
RUN echo "Welcome to the DesignSafe-ci JupyterHub terminal. Your DesignSafe-ci home directory is in 'mydata.' Any files you wish to save between sessions must be within that directory. OpenSees is availavble to run interactively here. " > /home/jupyter/README.txt
COPY rbnb.jar /home/jupyter/util/rbnb.jar

