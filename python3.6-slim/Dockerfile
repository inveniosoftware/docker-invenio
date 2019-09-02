FROM python:3.6-slim

# set the locale
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

# required debian packages
RUN set -ex \
  && buildDeps=' \
    curl \
    gcc \
    libc6-dev \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
  ' \
  && apt-get update \
  && apt-get install --no-install-recommends -y \
    git \
    gnupg \
    libxml2 \
    libxslt1.1 \
    locales \
    nodejs \
    npm \
    python3-cairosvg \
    $buildDeps \
  && localedef --quiet -c -i en_US -f UTF-8 en_US.UTF-8 \
  && pip --version \
  && pip install --no-cache --upgrade pip pipenv setuptools wheel \
  && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get install --no-install-recommends -y nodejs \
  && mkdir npm_install \
  && cd npm_install \
  && curl -SsL https://registry.npmjs.org/npm/-/npm-6.4.1.tgz | tar -xzf - \
  && cd package \
  && node bin/npm-cli.js rm npm -g \
  && node bin/npm-cli.js install -g $(node bin/npm-cli.js pack |tail -1) \
  && cd ../../ \
  && rm -rf npm_install \
  && apt-get purge -y --autoremove $buildDeps \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && rm -rf ${WORKING_DIR}/.cache

# SHELL ["/bin/bash", "-c"]

RUN npm config set prefix '${INVENIO_INSTANCE_PATH}/.npm-global'
ENV PATH=${INVENIO_INSTANCE_PATH}/.npm-global/bin:$PATH

# Set folder permissions
ENV INVENIO_USER_ID=1000
RUN chgrp -R 0 ${WORKING_DIR} && \
    chmod -R g=u ${WORKING_DIR}
RUN useradd invenio --uid ${INVENIO_USER_ID} --gid 0 && \
    chown -R invenio:root ${WORKING_DIR}
