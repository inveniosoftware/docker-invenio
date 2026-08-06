# SPDX-FileCopyrightText: 2026 Northwestern University.
# SPDX-FileCopyrightText: 2026 Frontmatter.
# SPDX-FileCopyrightText: 2026 KTH Royal Institute of Technology.
# SPDX-License-Identifier: MIT
#

ARG BUILD_PLATFORM=linux/amd64
ARG PYTHON_VERSION=3.14
ARG OS_VERSION=trixie
ARG NODE_VERSION=24
ARG PNPM_VERSION=latest-11
ARG INVENIO_WEBPACKEXT_NPM_PKG_CLS=pynpm:PNPMPackage

FROM --platform=${BUILD_PLATFORM} python:${PYTHON_VERSION}-${OS_VERSION}

LABEL org.opencontainers.image.source=https://github.com/inveniosoftware/docker-invenio

# ARGs declared before FROM are only global defaults. Redeclare build args in
# the stage where they are used so passed values are in scope:
# https://docs.docker.com/build/building/variables/#scoping
ARG NODE_VERSION
ARG PNPM_VERSION
ARG INVENIO_WEBPACKEXT_NPM_PKG_CLS

ENV \
    WORKING_DIR=/opt/invenio \
    INVENIO_INSTANCE_PATH=/opt/invenio/var/instance \
    INVENIO_USER_ID=1000 \
    PATH=/opt/invenio/src/.venv/bin:${PATH}

# Create relevant application directories
RUN mkdir -p \
    ${WORKING_DIR}/src \
    ${INVENIO_INSTANCE_PATH}/data \
    ${INVENIO_INSTANCE_PATH}/archive \
    ${INVENIO_INSTANCE_PATH}/static

# Invenio file will be in <WORKING_DIR>/src
WORKDIR ${WORKING_DIR}/src

# Set folder permissions
RUN chgrp -R 0 ${WORKING_DIR} && \
    chmod -R g=u ${WORKING_DIR} && \
    useradd invenio --uid ${INVENIO_USER_ID} --gid 0 && \
    chown -R invenio:root ${WORKING_DIR}

# Install system dependencies
#  The --mount=type=cache helps cache local builds and
#  will only yield a benefit to a CI if the CI also
#  preserves filesystem between runs
#
#  InvenioRDM requires the following packages that Debian already provides
#    ca-certificates
#    curl
#    gcc
#    git
#    imagemagick
#    libbz2-dev
#    libcairo2
#    libffi-dev
#    liblzma-dev
#    libpq-dev
#    libssl-dev
#    libsqlite3-dev
#    libxml2-dev
#    libxslt1-dev
RUN \
    --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get upgrade --yes \
    && \
    # Install Node.js deb source
    curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
    && \
    # Install system dependencies
    apt-get install --yes --no-install-recommends \
        build-essential \
        fonts-dejavu \
        locales \
        nodejs \
    && \
    # Install pnpm
    npm install -g pnpm@${PNPM_VERSION} \
    && \
    pip install pipenv

# Setup uv
# From https://docs.astral.sh/uv/guides/integration/docker/
# but using docker.io/astral/uv because failure to fetch oauth token
COPY --from=docker.io/astral/uv:0.11 /uv /uvx /bin/

# Set locale
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8
