# -*- coding: utf-8 -*-
#
# This file is part of Invenio.
#
# Copyright (C) 2024 Graz University of Technology.
#
# Invenio is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more
# details.
#

FROM alpine:edge

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV PYTHONUNBUFFERED=1
ENV PIPENV_VERBOSITY=-1
ENV VIRTUAL_ENV=/opt/env
ENV WORKING_DIR=/opt/invenio
ENV INVENIO_INSTANCE_PATH=${WORKING_DIR}/var/instance
ENV PYTHONUSERBASE=$VIRTUAL_ENV
ENV PATH=$VIRTUAL_ENV/bin:$PATH
ENV PYTHONPATH $VIRTUAL_ENV/lib/python3.12:$PATH


# xmlsec is for saml
# gcc to build wheels
# nodejs to build the statics
# cairo for some frontend things. maybe not necessary here
# python is obvious

RUN apk update
RUN apk add --update --no-cache \
    "python3>3.12" \
    "python3-dev>3.12" \
    "nodejs>20" \
    "npm>10" \
    git \
    cairo \
    autoconf \
    automake \
    bash \
    build-base \
    file \
    gcc \
    libtool \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    xmlsec-dev \
    xmlsec --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community

RUN python -m venv ${VIRTUAL_ENV}
RUN source ${VIRTUAL_ENV}/bin/activate
RUN pip install --upgrade pip setuptools pipenv

# Temporary solution:
# not more necessary after new release of xmlsec
# https://github.com/xmlsec/python-xmlsec/issues/316
# NOTE: --only-binary is not working!!!! it builds but it fails on runtime
RUN pip install --no-binary=xmlsec --no-binary=lxml lxml xmlsec

WORKDIR ${WORKING_DIR}/src

RUN mkdir -p ${INVENIO_INSTANCE_PATH}

ENTRYPOINT [ "bash", "-c"]
