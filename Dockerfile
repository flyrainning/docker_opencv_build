FROM ubuntu:16.10
MAINTAINER Flyrainning "http://www.fengpiao.net"



RUN apt-get update -y \
  && apt-get install -y \
    build-essential cmake git \
    v4l-utils usbutils toilet \
  && apt-get autoclean \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/*
    
    
RUN mkdir /opencv \
  && cd /opencv \
  && git clone https://github.com/opencv/opencv.git \
  && git clone https://github.com/opencv/opencv_contrib.git \
  && mkdir release \
  && cd release \
  && cmake -D OPENCV_EXTRA_MODULES_PATH=/opencv/opencv_contrib/modules -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local /opencv/opencv \
  && make -j 3 \
  && make install \
  && rm -rf /opencv


ENV VERSION 1
ENV PATH "/app:/app/build:$PATH"

ADD app /app
ADD bin /bin
WORKDIR /app

CMD ["/bin/bash"]
