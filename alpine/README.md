# Alpine docker base image

Quick informations:
- alpine linux as base
- python>3.12
- nodejs>20
- final image around 800 MB
- build time around 10 min (mostly install python packages and build statics)

## Builder

The base image for the builder stage is constructed to have all
necessary packages to install the python packages and build the
frontend statics. The size for the builder base image matters too but
it is difficult to optimize it more because the packages are all
necessary to install afterwords the python virtual environment and
build the statics. The biggest part is there the installed python
packages and the installed nodejs packages.

## App

The base image for the app stage is designed to have the smallest
possible size. Only the really necessary packages are installed.

## Multistage build

below is an example implementation of the multistage Dockerfile. There
is still room for optimization. The builder stage is more or less what
it is but for the app stage it would be possible to optimize the
filesize a little bit more. This are then mostly indivual improvements.

Possible further filesize optimizations (estimated max 200MB):
- remove pyc files before copying over
- remove all files which where used to build the statics and therefore useless for production
- remove the app_data directory. only necessary for initialisation of the database not necessary for production
- remove not used python packages like citation styles, ...

Possible further build time optimization:
- place as much into the base images as possible
- most of the python package dependencies
- precalculate a node_modules directory into the builder base image

```Dockerfile

# this multistage stage installs the python packages and builds the
# frontend static files
FROM base-image-builder as builder

COPY Pipfile Pipfile.lock ./

# Install all the dependecies defined in the Pipfile.
RUN pipenv install --deploy --system --pre

# Temporary solution:
# compatibility reasons. python3.12 does not have importlib-metadata
# anymore and it is needed in some packages
RUN pip install importlib-metadata

COPY ./app_data/ ${INVENIO_INSTANCE_PATH}/app_data/
COPY ./assets/ ${INVENIO_INSTANCE_PATH}/assets/
COPY ./static/ ${INVENIO_INSTANCE_PATH}/static/
COPY ./translations ${INVENIO_INSTANCE_PATH}/translations/
COPY ./templates ${INVENIO_INSTANCE_PATH}/templates/

RUN invenio collect --verbose && \
    invenio webpack create && \
    invenio webpack buildall


# this multistage stage is the final stage to run the worker and ui
# and api's. it contains only what is necessary therefore it copies
# over only the python packages and the static's. node and all
# node_modules packages are not necessary to run the app.
from base-image-app as app

COPY --from=builder ${VIRTUAL_ENV}/lib ${VIRTUAL_ENV}/lib
COPY --from=builder ${VIRTUAL_ENV}/bin ${VIRTUAL_ENV}/bin
COPY --from=builder ${INVENIO_INSTANCE_PATH}/app_data ${INVENIO_INSTANCE_PATH}/app_data
COPY --from=builder ${INVENIO_INSTANCE_PATH}/static ${INVENIO_INSTANCE_PATH}/static
COPY --from=builder ${INVENIO_INSTANCE_PATH}/translations ${INVENIO_INSTANCE_PATH}/translations
COPY --from=builder ${INVENIO_INSTANCE_PATH}/templates ${INVENIO_INSTANCE_PATH}/templates

WORKDIR ${WORKING_DIR}/src

# TODO:
# add here further things what should be in the final container

COPY ./saml/idp/cert/ ./saml/idp/cert/
COPY ./migrations/ ./migrations/
COPY ./wipe_recreate.sh .
COPY ./docker/uwsgi/ ${INVENIO_INSTANCE_PATH}
COPY ./invenio.cfg ${INVENIO_INSTANCE_PATH}

# so that the user invenio can execute the wipe_recreate script
RUN chmod 755 wipe_recreate.sh
RUN chown invenio:invenio wipe_recreate.sh

# this step ensures that the user invenio could write to the
# ${WORKING_DIR}/src which is necessary for the worker to
# write the celerybeat schedule file
RUN chown invenio:invenio .

# this step ensures that the docker container is not running as root.
# since virtually no file belongs to the user, he can do almost
# nothing except what he is supposed to do
USER invenio

# Instruction used to configure how the container will run.
ENTRYPOINT [ "bash", "-c"]

```
