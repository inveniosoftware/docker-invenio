# SPDX-FileCopyrightText: 2018-2021 CERN.
# SPDX-FileCopyrightText: 2022 Graz University of Technology.
# SPDX-FileCopyrightText: 2022 University of Münster.
# SPDX-FileCopyrightText: 2023-2024 KTH Royal Institute of Technology.
# SPDX-License-Identifier: MIT
#
ARG PYTHON_VERSION=3.12
ARG LINUX_VERSION=9
ARG NODEJS_VERSION=22
ARG BUILDPLATFORM=linux/amd64
FROM --platform=$BUILDPLATFORM almalinux:${LINUX_VERSION}

ARG PYTHON_VERSION
RUN dnf install -y python${PYTHON_VERSION} python${PYTHON_VERSION}-devel python${PYTHON_VERSION}-pip\
    && dnf clean all

ARG PYTHON_VERSION
RUN python${PYTHON_VERSION} -m pip install --upgrade pip setuptools wheel

# Symlink Python
ARG PYTHON_VERSION
RUN ln -sfn /usr/bin/python${PYTHON_VERSION} /usr/local/bin/python3 && \
    ln -sfn /usr/bin/pip${PYTHON_VERSION} /usr/local/bin/pip3

RUN dnf upgrade --refresh -y && \
    dnf install -y \
        dnf-plugins-core \
        git \
        glibc-common \
        glibc-locale-source \
        glibc-langpack-en \
        gcc

RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# EPEL: Extra Packages for Enterprise Linux 9
# `epel-release` is not recent/complete enough, as some packages below are missing
ARG LINUX_VERSION
RUN dnf config-manager --set-enabled crb && \
    dnf install -y \
        https://dl.fedoraproject.org/pub/epel/epel-release-latest-${LINUX_VERSION}.noarch.rpm

# Install needed and useful tools:
#  - python and friends
#  - basic system tools (procps-ng, htop, less, git, glibc, wget, curl)
#  - process/file inspection tools (strace, lsof, file)
#  - performance monitoring tools (iotop, iftop)
#  - networking tools (tcpdump, bind-utils)
# The installation of "Development Tools" should not be required. Be aware of its
# size ~1.1 Gb
RUN dnf install -y \
        pip \
        python3-devel \
        cairo-devel \
        dejavu-sans-fonts \
        libffi-devel \
        libpq-devel \
        libxml2-devel \
        libxslt-devel \
        ImageMagick \
        openssl-devel \
        bzip2-devel \
        xz-devel \
        sqlite-devel \
        xmlsec1-devel \
        procps-ng htop less \
        strace lsof file \
        iotop iftop \
        tcpdump bind-utils

# `python3-packaging` is installed by `yum` and it causes issues with `pip` installations
RUN yum remove python3-packaging -y
RUN pip3 install --upgrade pip pipenv wheel

COPY --from=docker.io/astral/uv:0.11 /uv /uvx /bin/


# Install Node.js
ARG NODEJS_VERSION
RUN curl -fsSL https://rpm.nodesource.com/setup_${NODEJS_VERSION}.x | bash - && \
    dnf -y install nodejs

# Reduce image size: clean up caches, remove RPM db files
RUN dnf clean all && \
    rm -rf \
        /var/cache/dnf \
        /var/lib/rpm/__db* \
        /var/lib/rpm/rpmdb.sqlite \
        /var/lib/rpm/Packages

# Create working directory
ENV WORKING_DIR=/opt/invenio
ENV INVENIO_INSTANCE_PATH=${WORKING_DIR}/var/instance

# Create files mountpoints
RUN mkdir -p ${WORKING_DIR}/src && \
    mkdir -p ${INVENIO_INSTANCE_PATH} && \
    mkdir \
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
