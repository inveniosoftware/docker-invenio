# Invenio docker images

[![Build Status](https://github.com/inveniosoftware/docker-invenio/workflows/CI/badge.svg)](https://github.com/inveniosoftware/docker-invenio/actions)

This image serves as base image for [Invenio](https://github.com/inveniosoftware/invenio) instances running on AlmaLinux.
The purpose is to provide a base image that is usable in production environments like OpenShift.

The image is based on the AlmaLinux9 image and contains:

- Python 3.9 set as default Python interpreter with upgraded versions of pip, pipenv, setuptools and wheel.
- Node 18.x
- Tools: Git, Curl Vim, Emacs, Development Tools.
- Library devel packages: libffi, libxml2, libxslt.
- Working directory for an Invenio instance.

## Supported tags and respective ``Dockerfile`` links

| Tag | Python version | Base AlmaLinux version | Dockerfile |
| --- | -------------- | ------------------- | ---------- |
| [inveniosoftware/centos7-python:3.6]( https://hub.docker.com/r/inveniosoftware/centos7-python) | 3.9 | 9        | [python3.6/Dockerfile](https://github.com/inveniosoftware/docker-invenio/blob/master/python3.6/Dockerfile) |



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

Copyright (C) 2018-2022 CERN.

Docker-Invenio is free software; you can redistribute it and/or modify it
under the terms of the MIT License; see LICENSE file for more details.
