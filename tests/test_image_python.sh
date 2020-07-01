#!/bin/bash

python_version=$1

if ! hash python; then
    echo "Image does not have python installed."
    echo 1 >> /tmp/tests_output.txt
    exit 1
fi

ver=$(python -V 2>&1 | sed 's/.* \([0-9]\).\([0-9]\).*/\1.\2/')
if [ "$ver" != "$python_version" ]; then
    echo "Image does not use python $python_version."
    echo 1 >> /tmp/tests_output.txt
    exit 1
fi

if ! hash pip; then
    echo "Image does not have pip installed."
    echo 1 >> /tmp/tests_output.txt
    exit 1
fi

if [ $(npm config get prefix) != '/opt/invenio/var/instance/.npm-global' ]; then
    echo "Image does not have the correct npm prefix configured."
    echo 1 >> /tmp/tests_output.txt
    exit 1
fi

echo 0 >> /tmp/tests_output.txt
