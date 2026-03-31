# Invenio Docker images

[![Build Status](https://github.com/inveniosoftware/docker-invenio/workflows/CI/badge.svg)](https://github.com/inveniosoftware/docker-invenio/actions)

This repository defines the Dockerfiles for the foundational Docker images usable in production environments like Docker Compose, Kubernetes, OpenShift, or other container orchestrators.
These Dockerfiles are for any Invenio-based app:
* [InvenioRDM](https://github.com/inveniosoftware/invenio-app-rdm)
* [InvenioILS](https://github.com/inveniosoftware/invenio-app-ils)
* [Invenio](https://github.com/inveniosoftware/invenio)

## Provided images

The provided images are the ones supported by CERN and/or an Invenio partner organization.

| Operating System | Dockerfile FROM                                   | Supporting organization                                    |
| ---------------- | ------------------------------------------------- | ---------------------------------------------------------- |
| AlmaLinux - v9   | FROM registry.cern.ch/inveniosoftware/almalinux:1 | CERN (@ntarocco)                                           |
| Debian - trixie  | FROM TBD                                          | Northwestern University (@fenekku), Frontmatter (@mfenner) |
|                  |                                                   |                                                            |

All images provide a common baseline of:
- Python and uv versions
- Node, npm and pnpm version
- development headers for all Invenio dependencies
- "invenio" user with uid 1000
- /opt/invenio/ working directory and appropriate subdirectories

Previous images, still available in this repository for reference only, were based on `CentOS`: after the [shift from CentOS to CentOS Stream](https://blog.centos.org/2020/12/future-is-centos-stream/), the main image is now based on [AlmaLinux](https://almalinux.org/), a free alternative downstream rebuild of Red Hat Enterprise Edition.

## Usage

### Create a ``Dockerfile``

Your own simple ``Dockerfile`` using one of the base image would look like this:

```dockerfile
# Select the FROM line, you want. For AlmaLinux, it would be:
FROM registry.cern.ch/inveniosoftware/almalinux:1
```

### Build and run the Docker image

To test the Docker image locally, you can build it and run it by doing:

```bash
docker build . -t my-image:1
docker run -it my-image:1 /bin/bash
```

## Optimization

You can use a tool like [dive](https://github.com/wagoodman/dive) to explore the layers of the Docker images and optimize it in your own Dockerfile.
