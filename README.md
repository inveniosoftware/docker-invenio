# CentOS 7 with Python 3 for Invenio

[![Build Status](https://travis-ci.org/inveniosoftware/docker-invenio.svg?branch=master)](https://travis-ci.org/inveniosoftware/docker-invenio) [![image](https://img.shields.io/docker/automated/inveniosoftware/centos7-python.svg)](https://hub.docker.com/r/inveniosoftware/centos7-python/) [![image](https://img.shields.io/docker/build/inveniosoftware/centos7-python.svg)](https://hub.docker.com/r/inveniosoftware/centos7-python/builds/)

This image serves as base image for [Invenio](https://github.com/inveniosoftware/invenio) instances running on CentOS7. The purpose is to provide a base image that is usable in production environments like OpenShift.

The image is based on the official CentOS image ``centos:7`` and contains:

- Python 3.6 set as default Python interpreter with upgraded versions of pip, pipenv, setuptools and wheel.
- Tools: Node.js, NPM, Git, Curl Vim, Emacs, Development Tools.
- Library devel packages: libffi, libxml2, libxslt.
- Working directory for an Invenio instance.

## Supported tags and respective ``Dockerfile`` links

* 3.6 - [Dockerfile](https://github.com/inveniosoftware/docker-invenio/blob/master/python3.6/Dockerfile).

## Usage

This image is used by the scaffolded Dockerfile in the Invenio [getting started guide](https://inveniosoftware.org/gettingstarted/). See the guide for quickly getting started.

### Create a ``Dockerfile``

A simple ``Dockerfile`` using this base image could look like this:

```
FROM inveniosoftware/centos7-python:3.6
COPY ./ .
COPY ./docker/uwsgi/ ${INVENIO_INSTANCE_PATH}
RUN ./scripts/bootstrap
```

### Environment variables

The following environment variables has been set:

- ``WORKING_DIR=/opt/invenio``
- ``INVENIO_INSTANCE_PATH=/opt/invenio/var/instance``
- ``INVENIO_USER_ID=1000``

### Rolling builds

The image is rebuild when the base image ``centos7:latest`` is updated.  The base image is receiving regular monthly updates as well as emergency fixes.

## Automated builds

Automated builds are configured using [Docker Hub builds](https://docs.docker.com/docker-hub/builds/). The triggers are defined the following way:

```(bash)
Branch/tag               Dockerfile                Docker tag

Push to master     ---> /python3.6/Dockerfile ---> 3.6
Push /^3\.6.*/ tag ---> /python3.6/Dockerfile ---> git-tag-name, 3.6
```

This way, we will use tag `3.6` as latest for Python version and there is also the possibility to push tags for specific use cases such as pinning certain libraries or patches.

## License

Copyright (C) 2018-2019 CERN.

Docker-Invenio is free software; you can redistribute it and/or modify it
under the terms of the MIT License; see LICENSE file for more details.
