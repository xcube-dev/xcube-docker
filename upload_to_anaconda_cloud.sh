#!/usr/bin/env bash

set -e

echo "branch:  $TRAVIS_BRANCH"
echo "event:   $TRAVIS_EVENT_TYPE"
echo "repository: ${1}"
echo

echo "Uploading packages to conda"

find $HOME/miniconda/conda-bld/ -name *.tar.bz2 | while read file
do
    echo anaconda -v -t ${anaconda_token} upload ${file} -u bc-dev --force;
    anaconda -v -t ${anaconda_token} upload ${file} -u bc-dev --force;
    echo $?
done
