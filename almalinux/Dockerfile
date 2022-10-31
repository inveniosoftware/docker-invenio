#
# Copyright (C) 2018-2021 CERN.
# Copyright (C) 2022 Graz University of Technology.
# Copyright (C) 2022 University of Münster.
#
# Invenio is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#
ARG LINUX_VERSION=9.0
ARG BUILDPLATFORM=linux/amd64
FROM --platform=$BUILDPLATFORM almalinux:${LINUX_VERSION}

RUN dnf upgrade --refresh -y && \
    dnf install -y \
        dnf-plugins-core \
        git \
        glibc-common \
        glibc-locale-source \
        glibc-langpack-en

RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# crb is needed to install epel, epel contains ImageMagick
RUN dnf config-manager --set-enabled crb && \
    dnf install -y \
        https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm

RUN dnf groupinstall -y "Development Tools" && \
    dnf install -y \
        pip \
        python3-devel \
        cairo-devel \
        dejavu-sans-fonts \
        libffi-devel \
        libxml2-devel \
        libxslt-devel \
        ImageMagick \
        openssl-devel \
        bzip2-devel \
        xz-devel \
        sqlite-devel \
        xmlsec1-devel

# Symlink Python
RUN ln -sfn /usr/bin/python3 /usr/bin/python
# `python3-packaging` is installed by `yum` and it causes issues with `pip` installations
RUN yum remove python3-packaging -y
RUN pip3 install --upgrade pip pipenv wheel

# Install Node.js v16
RUN curl -fsSL https://rpm.nodesource.com/setup_16.x | bash - && \
    yum install -y nodejs

# Create working directory
ENV WORKING_DIR=/opt/invenio
ENV INVENIO_INSTANCE_PATH=${WORKING_DIR}/var/instance

# Create files mountpoints
RUN mkdir -p ${INVENIO_INSTANCE_PATH} && \
    mkdir ${INVENIO_INSTANCE_PATH}/data ${INVENIO_INSTANCE_PATH}/archive ${INVENIO_INSTANCE_PATH}/static

# copy everything inside /src
RUN mkdir -p ${WORKING_DIR}/src
WORKDIR ${WORKING_DIR}/src

# Set folder permissions
ENV INVENIO_USER_ID=1000
RUN chgrp -R 0 ${WORKING_DIR} && \
    chmod -R g=u ${WORKING_DIR}
RUN useradd invenio --uid ${INVENIO_USER_ID} --gid 0 && \
    chown -R invenio:root ${WORKING_DIR}
