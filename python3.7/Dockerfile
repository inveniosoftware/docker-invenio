# common image to install Python 3.7 on Debian buster, updates, needed packages and NPM
FROM python:3.7-slim-buster

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        git \
        rlwrap \
        screen \
        vim \
        gcc \
        emacs-nox \
        libffi-dev \
        libxml2-dev \
        libxslt-dev \
        libcairo-5c0 \
        # For localedef
        locales && \
     apt-get clean


# install nodejs version 10
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    apt-get clean

RUN pip install --upgrade pip 'pipenv<2020-05-28' setuptools wheel --no-cache-dir

# set the locale
RUN localedef --quiet -c -i en_US -f UTF-8 en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

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
