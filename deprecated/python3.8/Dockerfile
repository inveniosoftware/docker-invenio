#
# Copyright (C) 2018-2020 CERN.
# Copyright (C) 2020 Cottage Labs LLP.
# Copyright (C) 2021 TU Wien.
# Copyright (C) 2021 Graz University of Technology.
#
# Invenio is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#
ARG CENTOS_VERSION=8
FROM centos:${CENTOS_VERSION}

# set the locale
# avoid Failed to set locale, defaulting to C.UTF-8
RUN yum install -y glibc-locale-source
RUN localedef --quiet -c -i en_US -f UTF-8 en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN yum install -y \
        yum-utils \
        curl \
        git \
        tmux \
        vim \
        python38 \
        python38-pip \
        python38-devel \
        emacs-nox && \
    yum install -y \
        epel-release && \
    yum groupinstall -y "Development Tools" && \
    yum install -y \
        cairo-devel \
        dejavu-sans-fonts \
        libffi-devel \
        libxml2-devel \
        libxslt-devel \
        ImageMagick

RUN yum clean -y all

# install nodejs version 14
RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash - && \
    yum install -y nodejs

# Symlink python
RUN ln -sfn /usr/bin/python3.8 /usr/bin/python3 & \
    ln -sfn /usr/bin/python3 /usr/bin/python & \
    ln -sfn /usr/bin/pip3.8 /usr/bin/pip3 & \
    ln -sfn /usr/bin/pip3 /usr/bin/pip

# setuptools v58 removed 2to3 support: https://setuptools.pypa.io/en/latest/history.html#v58-0-0
# the `fs` package relies on `2to3`
RUN pip3 install --upgrade pip pipenv "setuptools<58" wheel

# Create working directory
ENV WORKING_DIR=/opt/invenio
ENV INVENIO_INSTANCE_PATH=${WORKING_DIR}/var/instance
RUN mkdir -p ${INVENIO_INSTANCE_PATH}

# Create files mountpoints
RUN mkdir ${INVENIO_INSTANCE_PATH}/data
RUN mkdir ${INVENIO_INSTANCE_PATH}/archive
RUN mkdir ${INVENIO_INSTANCE_PATH}/static

# copy everything inside /src
RUN mkdir -p ${WORKING_DIR}/src
WORKDIR ${WORKING_DIR}/src

# Set `npm` global under Invenio instance path
RUN mkdir ${INVENIO_INSTANCE_PATH}/.npm-global
ENV NPM_CONFIG_PREFIX=$INVENIO_INSTANCE_PATH/.npm-global
RUN mkdir npm_install && cd npm_install && \
    curl -SsL https://registry.npmjs.org/npm/-/npm-6.14.5.tgz | tar -xzf - && \
    cd package && \
    node bin/npm-cli.js rm npm -g && \
    node bin/npm-cli.js install -g $(node bin/npm-cli.js pack | tail -1) && \
    cd ../.. && rm -rf npm_install

RUN npm config set prefix '${INVENIO_INSTANCE_PATH}/.npm-global'
ENV PATH=${INVENIO_INSTANCE_PATH}/.npm-global/bin:$PATH

# Set folder permissions
ENV INVENIO_USER_ID=1000
RUN chgrp -R 0 ${WORKING_DIR} && \
    chmod -R g=u ${WORKING_DIR}
RUN useradd invenio --uid ${INVENIO_USER_ID} --gid 0 && \
    chown -R invenio:root ${WORKING_DIR}
