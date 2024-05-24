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

ENV VIRTUAL_ENV=/opt/env
ENV WORKING_DIR=/opt/invenio
ENV INVENIO_INSTANCE_PATH=${WORKING_DIR}/var/instance
ENV PATH=$VIRTUAL_ENV/bin:$PATH


# python is to run the webserver
# libxslt-dev is a dependency
# xmlsec is for saml
# cairo is for image processing
# uwsgi-python3 to provide the webserver
# bash is not really necessary but a nicer terminal then sh
RUN apk update
RUN apk add --update --no-cache \
    "python3>3.12" \
    libxslt-dev \
    xmlsec \
    cairo \
    uwsgi-python3 \
    bash --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community

RUN python -m venv ${VIRTUAL_ENV}

RUN source ${VIRTUAL_ENV}/bin/activate

RUN mkdir -p ${INVENIO_INSTANCE_PATH}
RUN mkdir -p ${VIRTUAL_ENV}
RUN mkdir -p ${WORKING_DIR}/src/saml/idp/cert

RUN adduser invenio --no-create-home --disabled-password

RUN rm /opt/env/bin/python && ln -s /usr/bin/python python

ENTRYPOINT [ "bash", "-c"]
