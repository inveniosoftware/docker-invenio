# common image to install CentOS7, updates, needed packages and NPM
FROM centos:8.2.2004

RUN yum install -y \
        yum-utils \
        curl \
        git \
        tmux \
        vim \
        python38 \
        python38-pip \
        emacs-nox && \
    yum install -y \
        epel-release && \
    yum groupinstall -y "Development Tools" && \
    yum install -y \
        cairo-devel \
        libffi-devel \
        libxml2-devel \
        libxslt-devel

RUN yum clean -y all

# install nodejs version 14
RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash - && \
    yum install -y nodejs

RUN pip3 install --upgrade pip 'pipenv<2020-05-28' setuptools wheel

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
