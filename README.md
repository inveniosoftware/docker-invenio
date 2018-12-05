Docker Invenio
==============

[![image](https://img.shields.io/docker/automated/inveniosoftware/centos7-python.svg)](https://hub.docker.com/r/inveniosoftware/centos7-python/)
[![image](https://img.shields.io/docker/build/inveniosoftware/centos7-python.svg)](https://hub.docker.com/r/inveniosoftware/centos7-python/builds/)

Docker base images for [Invenio](https://github.com/inveniosoftware/invenio).

Supported tags and respective Dockerfile links
--------------

* 3.6 [docker/Dockerfile](https://github.com/inveniosoftware/docker-invenio/blob/master/python3.6/Dockerfile).
* 3.7 [docker/Dockerfile](https://github.com/inveniosoftware/docker-invenio/blob/master/python3.7/Dockerfile).

Quick reference
--------------

* Where to get help:
[the Docker Community Forums](https://forums.docker.com/), [the Docker Community Slack](https://blog.docker.com/2016/11/introducing-docker-community-directory-docker-community-slack/), or [Stack Overflow](https://stackoverflow.com/search?tab=newest&q=docker).

* Where to file issues:
https://github.com/inveniosoftware/docker-invenio/issues.

* Maintained by:
[Invenio](https://github.com/inveniosoftware/).

Automic builds
--------------

Automatic builds are configured using [Docker Hub
builds](https://docs.docker.com/docker-hub/builds/). The tiggers are
defined the following way:

``` {.sourceCode .}
Branch/tag            Dockerfile                 Docker tag

Push to master        ---> /python3.6/Dockerfile ---> 3.6
Push to master        ---> /python3.7/Dockerfile ---> 3.7
Push /^3\.6.*/ tag    ---> /python3.6/Dockerfile ---> git-tag-name, 3.6
Push /^3\.7.*/ tag    ---> /python3.7/Dockerfile ---> git-tag-name, 3.7
```

That way, we will use tags `3.6` and `3.7` as latest for these Python
versions and there is also the possibility to push tags for specific use
cases such as pinning certain libraries or patches. To modify the
aforementioned configuration you can access [Inveniosoftware
DockerHub](https://hub.docker.com/r/inveniosoftware/centos7-python/~/settings/automated-builds/).

License
-------

This file is part of Invenio.
Copyright (C) 2015-2018 CERN.

Invenio is free software; you can redistribute it and/or modify it
under the terms of the MIT License; see LICENSE file for more details.
