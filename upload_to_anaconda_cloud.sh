#!/usr/bin/env bash

set -e

echo "branch:  $TRAVIS_BRANCH"
echo "event:   $TRAVIS_EVENT_TYPE"
echo "package: $1"
echo

CONDA_PACKAGES=( $(conda build -c conda-forge -c defaults xcube --output) )
echo "Start Processing"

echo "Converting package to other platforms"
platforms=( osx-64 win-64 )

for package in "${CONDA_PACKAGES[@]}"
do
    for platform in "${platforms[@]}"
    do
        conda convert --platform ${platform} ${package}  -o $HOME/miniconda/conda-bld/
    done
done

echo "Uploading packages to conda"
find $HOME/miniconda/conda-bld/ -name *.tar.bz2 | while read file
do
    anaconda -v -t ${anaconda_token} upload ${file} -u bc-dev --force;
done
