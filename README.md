# Invenio docker images

[![Build Status](https://github.com/inveniosoftware/docker-invenio/workflows/CI/badge.svg)](https://github.com/inveniosoftware/docker-invenio/actions)

This image serves as base image, usable in production environments like Kubernetes or OpenShift, for:
* [InvenioRDM](https://github.com/inveniosoftware/invenio-app-rdm)
* [InvenioILS](https://github.com/inveniosoftware/invenio-app-ils)
* [Invenio](https://github.com/inveniosoftware/invenio)

Previous images, still available in this repository for reference only, were based on `CentOS`: after the [shift from CentOS to CentOS Stream](https://blog.centos.org/2020/12/future-is-centos-stream/), the main image is now based on [AlmaLinux](https://almalinux.org/), a free alternative downstream rebuild of Red Hat Enterprise Edition.

The [current image](almalinux/Dockerfile) is based on the AlmaLinux version 9 and contains:

- Python v3.9 set as default Python interpreter with upgraded versions of pip, pipenv, setuptools and wheel.
- Node.js v16.x
- Working directory for an Invenio instance.

Images are currently published in the CERN registry `registry.cern.ch`.

## Usage

### Create a ``Dockerfile``

A simple ``Dockerfile`` using this base image could look like this:

```
FROM registry.cern.ch/inveniosoftware/almalinux:latest
```

### Rolling builds

The images are rebuilt when the base images are updated. The base image are receiving regular monthly
updates as well as emergency fixes.
