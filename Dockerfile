FROM arm32v6/alpine

RUN apk add --no-cache --virtual cancat-build-dependencies \
    git \
    build-base \
    python3-dev \
    py3-pip

ENV CANCAT_REVISION master
RUN git clone --depth 1 --branch ${CANCAT_REVISION} https://github.com/atlas0fd00m/CanCat.git /opt/cancat/bin/

WORKDIR /opt/cancat/bin
RUN pip3 install --prefix /opt/cancat/ \
    ipython \
    pyserial

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN python3 setup.py install --prefix=/opt/ancat/

