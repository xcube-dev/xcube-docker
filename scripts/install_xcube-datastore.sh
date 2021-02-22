#!/bin/env bash

PACKAGE=$1;
PACKAGE_VERSION=$2;

if [[ $PACKAGE_VERSION == *"dev"* ]]; then
  wget https://github.com/dcs4cop/"${PACKAGE}"/archive/v"${PACKAGE_VERSION}".tar.gz
  tar xvzf v"${PACKAGE_VERSION}".tar.gz

  cd "${PACKAGE}"-"${PACKAGE_VERSION}" || exit

  mamba update
  source activate xcube && pip install .
  cd .. && rm v"${PACKAGE_VERSION}".tar.gz
else
  mamba install -y -n xcube -c conda-forge "${PACKAGE}"="${PACKAGE_VERSION}"
fi




