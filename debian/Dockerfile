#
# Copyright (C) 2025 Northwestern University.
#
# Invenio is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#


ARG BUILD_PLATFORM=linux/amd64
ARG PYTHON_VERSION=3.14
ARG OS_VERSION=trixie
ARG NODE_VERSION=22

FROM --platform=${BUILD_PLATFORM} python:${PYTHON_VERSION}-${OS_VERSION}

LABEL org.opencontainers.image.source=https://github.com/inveniosoftware/docker-invenio

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    gcc \
    locales

RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

RUN apt-get install -y --no-install-recommends \
    build-essential \
    fonts-dejavu \
    imagemagick \
    libbz2-dev \
    libcairo2 \
    libffi-dev \
    liblzma-dev \
    libpq-dev \
    libssl-dev \
    libsqlite3-dev \
    libxml2-dev \
    libxslt1-dev

RUN pip install --upgrade pip pipenv wheel

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
    apt-get install -y nodejs npm

# Create working directory
ENV WORKING_DIR=/opt/invenio
ENV INVENIO_INSTANCE_PATH=${WORKING_DIR}/var/instance

# Create files mountpoints
RUN mkdir -p \
    ${WORKING_DIR}/src \
    ${INVENIO_INSTANCE_PATH}/data \
    ${INVENIO_INSTANCE_PATH}/archive \
    ${INVENIO_INSTANCE_PATH}/static

# Invenio file will be in <WORKING_DIR>/src
WORKDIR ${WORKING_DIR}/src

# Set folder permissions
ENV INVENIO_USER_ID=1000
RUN chgrp -R 0 ${WORKING_DIR} && \
    chmod -R g=u ${WORKING_DIR} && \
    useradd invenio --uid ${INVENIO_USER_ID} --gid 0 && \
    chown -R invenio:root ${WORKING_DIR}
