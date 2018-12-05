# common image to install CentOS7, updates, needed packages and NPM
FROM centos:7
ARG PROJECT_NAME
RUN : "${PROJECT_NAME:?Please provide the project name by passing for example:" \
" --build-arg PROJECT_NAME=invenio}"

RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm
RUN yum install -y \
        yum-utils \
        python36u \
        python36u-devel \
        python36u-pip \
        curl \
        git \
        rlwrap \
        screen \
        vim \
        emacs-nox && \
    yum install -y \
        epel-release && \
    yum groupinstall -y "Development Tools" && \
    yum install -y \
        libffi-devel \
        libxml2-devel \
        libxslt-devel \
        nodejs

RUN yum clean -y all

# set python3.6 as default
RUN alternatives --install /usr/bin/python python /usr/bin/python2 50
RUN alternatives --install /usr/bin/python python /usr/bin/python3.6 60
RUN alternatives --set python /usr/bin/python3.6

# symlink pip
RUN ln -s /usr/bin/pip3.6 /usr/bin/pip
RUN pip install --upgrade pip pipenv setuptools wheel

# set the locale
RUN localedef --quiet -c -i en_US -f UTF-8 en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Create working directory
ENV PROJECT_DIR=/opt/${PROJECT_NAME}
ENV INSTANCE_PATH=${PROJECT_DIR}/var/instance
RUN mkdir -p ${INSTANCE_PATH}

# copy everything inside /src
RUN mkdir -p ${PROJECT_DIR}/src
WORKDIR ${PROJECT_DIR}/src

# Set `npm` global under Invenio instance path
RUN mkdir ${INSTANCE_PATH}/.npm-global
ENV NPM_CONFIG_PREFIX=${INSTANCE_PATH}/.npm-global
RUN mkdir npm_install && cd npm_install && \
    curl -SsL https://registry.npmjs.org/npm/-/npm-6.4.1.tgz | tar -xzf - && \
    cd package && \
    node bin/npm-cli.js rm npm -g && \
    node bin/npm-cli.js install -g $(node bin/npm-cli.js pack | tail -1) && \
    cd ../.. && rm -rf npm_install

RUN npm config set prefix '${INSTANCE_PATH}/.npm-global'
ENV PATH=${INSTANCE_PATH}/.npm-global/bin:$PATH

# Set folder permissions
ENV USER_ID=1000
RUN chgrp -R 0 ${PROJECT_DIR} && \
    chmod -R g=u ${PROJECT_DIR}
RUN useradd invenio --uid ${USER_ID} --gid 0 && \
    chown -R invenio:root ${PROJECT_DIR}
