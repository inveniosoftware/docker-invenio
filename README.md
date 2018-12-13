# docker-invenio

[![Build Status](https://travis-ci.org/inveniosoftware/docker-invenio.svg?branch=master"BuildStatus\")](https://travis-ci.org/inveniosoftware/docker-invenio/branches?branch=master) [![image](https://img.shields.io/docker/automated/inveniosoftware/centos7-python.svg)](https://hub.docker.com/r/inveniosoftware/centos7-python/) [![image](https://img.shields.io/docker/build/inveniosoftware/centos7-python.svg)](https://hub.docker.com/r/inveniosoftware/centos7-python/builds/)

This repository contains Docker base images to generate the environment for
[Invenio](https://github.com/inveniosoftware/invenio) applications.

**Prerequisites** Docker: [https://docs.docker.com/install/](https://docs.docker.com/install/)

## Usage

Detailed usage is described in the [invenio getting started guide](https://invenio-software.org/gettingstarted/).

## Build the new images

Build the images by running the docker build with the appropiate tag, i.e:

`docker build -f python3.6/Dockerfile -t my-site-base .`

## Supported Tags and respective Dockerfile links

* 3.6 - [Dockerfile](https://github.com/inveniosoftware/docker-invenio/blob/master/python3.6/Dockerfile).

## Helpful resources

* [Docker Community Forums](https://forums.docker.com/)
* [Docker Community Slack](https://blog.docker.com/2016/11/introducing-docker-community-directory-docker-community-slack/)
* [Stack Overflow](https://stackoverflow.com/search?tab=newest&q=docker)
* [Issue tracker](https://github.com/inveniosoftware/docker-invenio/issues)

## Automated builds

Automated builds are configured using [Docker Hub builds](https://docs.docker.com/docker-hub/builds/). The tiggers are defined the following way:

```(bash)
Branch/tag               Dockerfile                Docker tag

Push to master     ---> /python3.6/Dockerfile ---> 3.6
Push /^3\.6.*/ tag ---> /python3.6/Dockerfile ---> git-tag-name, 3.6
```

That way, we will use tag `3.6` as latest for Python version and there is also the possibility to push tags for specific use cases such as pinning certain libraries or patches.

Maintained by: [InvenioSoftware](https://github.com/inveniosoftware/)

## License

This file is part of Invenio.
Copyright (C) 2015-2018 CERN.

Invenio is free software; you can redistribute it and/or modify it
under the terms of the MIT License; see LICENSE file for more details.
