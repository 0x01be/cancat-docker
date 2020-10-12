FROM arm32v6/alpine

RUN apk add --no-cache --virtual cancat-build-dependencies \
    git \
    build-base \
    python2-dev \
    py-pip

ENV CANCAT_REVISION master
RUN git clone --depth 1 --branch ${CANCAT_REVISION} https://github.com/atlas0fd00m/CanCat.git /opt/cancat/bin/

WORKDIR /opt/cancat/bin
RUN pip install --prefix /opt/cancat/ \
    ipython \
    pyserial

RUN python setup.py install --prefix=/opt/ancat/

