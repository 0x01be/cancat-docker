FROM 0x01be/cancat:build as build

FROM alpine

COPY --from=build /opt/ /opt/
COPY --from=build /root/.arduino15/ /root/.arduino15/

RUN apk add --no-cache --virtual cancat-runtime-dependencies \
    make \
    python2 &&\
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub &&\
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk &&\
    apk add glibc-2.32-r0.apk &&\
    echo "board_manager:" > /etc/arduino-cli.conf.yml &&\
    echo "  additional_urls:" >> /etc/arduino-cli.conf.yml &&\
    echo "    - https://macchina.cc/package_macchina_index.json" >> /etc/arduino-cli.conf.yml &&\
    arduino-cli lib install due_can

ENV FIRMWARE_DIR /opt/cancat/bin/sketches
ENV PROGRAM_COMMAND "make due"

ENV PATH ${PATH}:/opt/cancat/bin/:/opt/arduino/bin/:/root/.arduino15/packages/arduino/tools/arm-none-eabi-gcc/4.8.3-2014q1/bin/
ENV PYTHONPATH /opt/cancat/lib/python2.7/site-packages/:/opt/cancat/lib/python3.8/site-packages/

