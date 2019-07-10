#!/usr/bin/env bash

set -e

echo "branch:  $TRAVIS_BRANCH"
echo "event:   $TRAVIS_EVENT_TYPE"
echo "package: $1"
echo

if [[ "$TRAVIS_BRANCH" = "xcube98_dzelge_conda_package_deploy" ]]; then
    if [[ "$TRAVIS_EVENT_TYPE" = "api" || "$TRAVIS_EVENT_TYPE" = "push" ]]; then
        echo "Start uploading process"

		echo "Converting packages to other platforms"
		platforms=( osx-64 win-64 )
		find $HOME/miniconda/conda-bld/ -name *.tar.bz2 | while read file
		do
			for platform in "${platforms[@]}"
            do
                echo "Converting: ${file} to ${platform}"
               conda convert --platform ${platform} ${file}  -o $HOME/miniconda/convert-bld/
            done
		done


		echo "Uploading packages to conda"
		find $HOME/miniconda/conda-bld/ -name *.tar.bz2 | while read file
		do
			echo "Uploading: ${file}"
			anaconda -v -t ${anaconda_token} upload ${file} -u bc-dev --force;
		done

		echo "Uploading converted packages to conda"
		find $HOME/miniconda/convert-bld/ -name *.tar.bz2 | while read file
		do
			echo "Uploading: ${file}"
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