#!/bin/env bash


if [[ $XCUBE_INSTALL_MODE == "branch" ]]; then
  git clone https://github.com/dcs4cop/xcube
  cd xcube || exit
  git checkout "${XCUBE_VERSION}"
  mamba env create .
  source activate xcube && pip install .
  cd ..
  rm -rf xcube
elif [[ $XCUBE_INSTALL_MODE == "github" ]]; then
  wget https://github.com/dcs4cop/xcube/archive/v"${XCUBE_VERSION}".tar.gz
  tar xvzf v"${XCUBE_VERSION}".tar.gz

  cd xcube-"${XCUBE_VERSION}" || exit

  mamba env create .
  source activate xcube && pip install .
  cd ..
  rm v"${XCUBE_VERSION}".tar.gz
else
  mamba create -y -n xcube -c conda-forge xcube="${XCUBE_VERSION}"
fi



