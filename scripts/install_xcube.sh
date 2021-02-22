#!/bin/env bash


#if [[ $XCUBE_VERSION == *"dev"* ]]; then
  wget https://github.com/dcs4cop/xcube/archive/v"${XCUBE_VERSION}".tar.gz
  tar xvzf v"${XCUBE_VERSION}".tar.gz

  cd xcube-"${XCUBE_VERSION}" || exit

  mamba env create .
  source activate xcube && pip install .
#else
#  mamba create -y -n xcube -c conda-forge xcube="${XCUBE_VERSION}"
#fi




