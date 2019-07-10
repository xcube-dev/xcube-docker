#!/usr/bin/env bash

set -e

echo "branch:  $TRAVIS_BRANCH"
echo "event:   $TRAVIS_EVENT_TYPE"
echo "package: $1"
echo

if [[ "$TRAVIS_BRANCH" = "xcube98_dzelge_conda_package_deploy" ]]; then
    if [[ "$TRAVIS_EVENT_TYPE" = "api" || "$TRAVIS_EVENT_TYPE" = "push" ]]; then
        CONDA_PACKAGE=$(conda build -c conda-forge -c defaults xcube --output);
        echo "Processing ${CONDA_PACKAGE}"

		echo "Converting package to other platforms"
		platforms=( osx-64 win-64 )

        for platform in "${platforms[@]}"
        do
           echo "Converting: ${CONDA_PACKAGE} to ${platform}"
           echo conda convert --platform ${platform} ${CONDA_PACKAGE}  -o $HOME/miniconda/conda-bld/
           conda convert --platform ${platform} ${CONDA_PACKAGE}  -o $HOME/miniconda/conda-bld/
        done

		echo "Uploading packages to conda"
		find $HOME/miniconda/conda-bld/*/xcube* -name *.tar.bz2 | while read file
		do
			echo "Uploading: ${file}"
			echo anaconda -v -t ${anaconda_token} upload ${file} -u bc-dev --force;
			anaconda -v -t ${anaconda_token} upload ${file} -u bc-dev --force;
		done
    else
        echo "NOT uploading to Anaconda Cloud, because this is the wrong event type";
        echo "event $TRAVIS_EVENT_TYPE"
    fi
else
    echo "NOT uploading to Anaconda Cloud, because this is the wrong branch";
    echo "branch $TRAVIS_BRANCH";
fi