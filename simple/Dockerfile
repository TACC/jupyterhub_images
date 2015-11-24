FROM jupyter/singleuser

USER root
RUN pip3 install ipywidgets

ADD adamalib /adamalib
WORKDIR /adamalib
RUN python setup.py install
RUN python3 setup.py install