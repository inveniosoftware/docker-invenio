#!/bin/bash
# SPDX-FileCopyrightText: 2020-2022 CERN.
# SPDX-FileCopyrightText: 2026 Northwestern University.
# SPDX-License-Identifier: MIT

python_version=$1

if ! hash python; then
    echo "Image does not have python installed."
    echo 1 >> /tmp/tests_output.txt
    exit 1
fi

ver=$(python -V 2>&1 | grep -oE '[0-9]\.[0-9]+')
if [ "$ver" != "$python_version" ]; then
    echo "Image does not use python $python_version."
    echo "Image uses python ${ver}."
    echo 1 >> /tmp/tests_output.txt
    exit 1
fi

if ! hash pip; then
    echo "Image does not have pip installed."
    echo 1 >> /tmp/tests_output.txt
    exit 1
fi

if ! hash node; then
    echo "Image does not have node installed."
    echo 1 >> /tmp/tests_output.txt
    exit 1
fi

if ! hash npm; then
    echo "Image does not have npm installed."
    echo 1 >> /tmp/tests_output.txt
    exit 1
fi

echo 0 >> /tmp/tests_output.txt
