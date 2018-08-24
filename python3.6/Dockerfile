# common image to install CentOS7, updates, needed packages and NPM
FROM centos:7

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
        npm

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
ENV WORKING_DIR=/opt/invenio
ENV INVENIO_INSTANCE_PATH=${WORKING_DIR}/var/instance
RUN mkdir -p ${INVENIO_INSTANCE_PATH}

# copy everything inside /src
RUN mkdir -p ${WORKING_DIR}/src
WORKDIR ${WORKING_DIR}/src

# Set folder permissions
ENV INVENIO_USER_ID=1000
RUN chgrp -R 0 ${WORKING_DIR} && \
    chmod -R g=u ${WORKING_DIR}
RUN useradd invenio --uid ${INVENIO_USER_ID} --gid 0 && \
    chown -R invenio:root ${WORKING_DIR}

RUN npm update && \
    npm install --silent -g node-sass@3.8.0 clean-css@3.4.24 uglify-js requirejs
