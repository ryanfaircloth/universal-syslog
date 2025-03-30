ARG SYSLOGNG_VERSION=4.10.1
ARG US_VERSION
FROM ghcr.io/axoflow/axosyslog:${SYSLOGNG_VERSION} as base


RUN apk add -U --upgrade --no-cache \
    bash \
    musl \
    build-base \
    py3-pip \
    python3 \
    python3-dev \
    libffi-dev \
    postgresql-libs \
    poetry

FROM ghcr.io/axoflow/axosyslog:${SYSLOGNG_VERSION} as runtime
HEALTHCHECK NONE

RUN apk add -U --upgrade --no-cache \
    bash

COPY source /work