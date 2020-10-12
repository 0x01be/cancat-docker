FROM 0x01be/cancat:build as build

FROM alpine

COPY --from=build /opt/ /opt/
COPY --from=build /root/.arduino15/ /root/.arduino15/

RUN apk add --no-cache --virtual cancat-runtime-dependencies \
    python2

ENV FIRMWARE_DIR /opt/cancat/bin/sketches
ENV PROGRAM_COMMAND "make due"

ENV PATH ${PATH}:/opt/cancat/bin/:/opt/arduino/bin/:/root/.arduino15/packages/arduino/tools/arm-none-eabi-gcc/4.8.3-2014q1/bin/
ENV PYTHONPATH /opt/cancat/lib/python3.8/site-packages/

