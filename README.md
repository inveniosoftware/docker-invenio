# CentOS with Python 3 for Invenio

[![Build Status](https://github.com/inveniosoftware/docker-invenio/workflows/CI/badge.svg)](https://github.com/inveniosoftware/docker-invenio/actions) [![image](https://img.shields.io/docker/automated/inveniosoftware/centos7-python.svg)](https://hub.docker.com/r/inveniosoftware/centos7-python/) [![image](https://img.shields.io/docker/build/inveniosoftware/centos7-python.svg)](https://hub.docker.com/r/inveniosoftware/centos7-python/builds/)

This image serves as base image for [Invenio](https://github.com/inveniosoftware/invenio) instances running on CentOS.
The purpose is to provide a base image that is usable in production environments like OpenShift.

The image is based on the official CentOS `centos:7` and `centos:8.2.2004` images and contains:

- Python 3.6, 3.7 or 3.8 set as default Python interpreter with upgraded versions of pip, pipenv, setuptools and wheel.
- Tools: Node.js, NPM, Git, Curl Vim, Emacs, Development Tools.
- Library devel packages: libffi, libxml2, libxslt.
- Working directory for an Invenio instance.

## Supported tags and respective ``Dockerfile`` links

| Tag | Python version | Base CentOS version | Dockerfile |
| --- | -------------- | ------------------- | ---------- |
| [inveniosoftware/centos7-python:3.6]( https://hub.docker.com/r/inveniosoftware/centos7-python) | 3.6 | 7        | [python3.6/Dockerfile](https://github.com/inveniosoftware/docker-invenio/blob/master/python3.6/Dockerfile) |
| [inveniosoftware/centos8-python:3.7]( https://hub.docker.com/r/inveniosoftware/centos8-python) | 3.7 | 8.2.2004 | [python3.7/Dockerfile](https://github.com/inveniosoftware/docker-invenio/blob/master/python3.7/Dockerfile) |
| [inveniosoftware/centos8-python:3.8]( https://hub.docker.com/r/inveniosoftware/centos8-python) | 3.8 | 8.2.2004 | [python3.8/Dockerfile](https://github.com/inveniosoftware/docker-invenio/blob/master/python3.8/Dockerfile) |


## Usage

This image is used by the scaffolded Dockerfile in the Invenio [getting started
guide](https://inveniosoftware.org/gettingstarted/). See the guide for quickly getting started.


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

The images are rebuilt when the base images are updated.  The base image are receiving regular monthly
updates as well as emergency fixes.

## Automated builds

Automated builds are configured using [Docker Hub builds](https://docs.docker.com/docker-hub/builds/), with each
push to master initating a Docker Hub build that will be tagged per the table above.

## License

Copyright (C) 2018-2019 CERN.

Docker-Invenio is free software; you can redistribute it and/or modify it
under the terms of the MIT License; see LICENSE file for more details.
