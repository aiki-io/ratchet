FROM python:3.6-slim

LABEL maintainer="lech@aiki.io"

COPY requirements.txt /tmp/

RUN apt-get update \
&&  apt-get upgrade \
&&  apt-get install -y sudo \
&&  apt-get install -y g++ \
&&  adduser --gecos "" bender \
&&  passwd -d bender \
&&  usermod -aG sudo bender \
&&  mkdir /work \
&&  chown -R bender /work \
&&  pip install --no-cache-dir -r /tmp/requirements.txt


USER bender
WORKDIR /work
EXPOSE  1725
VOLUME /work

RUN mkdir /home/bender/.jupyter
COPY jupyter_notebook_config.py /home/bender/.jupyter
CMD jupyter notebook

 
