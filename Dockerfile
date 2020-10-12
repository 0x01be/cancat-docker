FROM 0x01be/cancat:build-arm32v6 as build

FROM arm32v6/alpine

COPY --from=build /opt/ /opt/

RUN apk add --no-cache --virtual cancat-runtime-dependencies \
    python2

ENV PATH ${PATH}:/opt/cancat/bin/
ENV PYTHONPATH /opt/cancat/lib/python3.8/site-packages/

