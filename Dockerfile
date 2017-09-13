#FROM arm32v7/debian:jessie
FROM arm32v7/ubuntu:xenial

RUN apt-get update && apt-get install -y \
  libssl-dev \
  libopencv-dev \
  libboost-dev \
  git \
  wget \
  python-pip \
  cmake \
  alsa-utils \
  sudo \
  curl \
  libjsonrpccpp-dev \
  libjsonrpccpp-tools

RUN pip install qibuild

RUN wget https://repo.continuum.io/archive/Anaconda2-4.2.0-Linux-x86.sh
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh; \
    /bin/bash Anaconda2-4.2.0-Linux-x86.sh -b -p /opt/conda; \
    rm Anaconda2-4.2.0-Linux-x86.sh

RUN git clone git://git.drogon.net/wiringPi && \
  cd wiringPi && \
  ./build

COPY tc_install.sh /tc_install.sh
RUN bash tc_install.sh
