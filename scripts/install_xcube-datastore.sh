#!/bin/env bash

PACKAGE=$1;
PACKAGE_VERSION=$2;

# if [[ ! $XCUBE_SH_USE_CONDA_FORGE ]]; then
  echo "############################################"
  echo "INSTALLING ${PACKAGE}-${PACKAGE_VERSION}"
  echo "############################################"
  wget https://github.com/dcs4cop/"${PACKAGE}"/archive/v"${PACKAGE_VERSION}".tar.gz
  tar xvzf v"${PACKAGE_VERSION}".tar.gz

  cd "${PACKAGE}"-"${PACKAGE_VERSION}" || exit

  sed -i "s/xcube/#xcube/g" environment.yml || exit
  source activate xcube && mamba env update -n xcube
  source activate xcube && pip install .
  cd .. && rm v"${PACKAGE_VERSION}".tar.gz
#else
#  mamba install -y -n xcube -c conda-forge "${PACKAGE}"="${PACKAGE_VERSION}"
#fi




