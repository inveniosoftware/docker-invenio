#!/bin/bash

if (( 0 == $(cat ./tests_output.txt) )); then
    echo "Image tests succeeded."
    exit 0
else
    echo "Image tests failed."
    exit 1
fi
