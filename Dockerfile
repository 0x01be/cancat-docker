FROM alpine

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk
RUN apk add glibc-2.32-r0.apk


RUN apk add --no-cache --virtual cancat-build-dependencies \
    wget \
    git \
    python2-dev \
    py-pip

ENV CANCAT_REVISION master
RUN git clone --depth 1 --branch ${CANCAT_REVISION} https://github.com/atlas0fd00m/CanCat.git /opt/cancat/bin/

WORKDIR /opt/cancat/bin
RUN pip install --prefix /opt/cancat/ \
    ipython \
    pyserial

RUN python setup.py install --prefix=/opt/cancat/

ADD https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh /opt/arduino/install.sh
WORKDIR /opt/arduino
RUN sh install.sh

ENV PATH ${PATH}:/opt/arduino/bin
RUN arduino-cli lib install due_can
RUN arduino-cli core install arduino:sam
#WORKDIR /opt/cancat/bin/sketches
#RUN make due

