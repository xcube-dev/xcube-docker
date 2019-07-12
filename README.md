[![Docker Repository on Quay](https://quay.io/repository/bcdev/xcube/status "Docker Repository on Quay")](https://quay.io/repository/bcdev/xcube)
[![Build Status](https://travis-ci.com/dcs4cop/xcube-conda.svg?branch=master)](https://travis-ci.com/dcs4cop/xcube-conda)
[![Anaconda-Server Badge](https://anaconda.org/bc-dev/xcube/badges/latest_release_date.svg)](https://anaconda.org/bc-dev/xcube)
[![Anaconda-Server Badge](https://anaconda.org/bc-dev/xcube/badges/platforms.svg)](https://anaconda.org/bc-dev/xcube)

# xcube-conda
Repository for deploying xcube as a conda package

## Description
This repository combines a conda and docker build as well as their deployment.

REMARK: The current setup would allow integrating the deployment to the repo xcube.

It follows these steps:

- Change versions in meta.yml, Dockerfile, .travis.yml
- push to a branch and await build
- Once build is successful create PR
- Once PR is accepted the master will be build on travis
- If that is successful, create a tag or release (and push it if you use the command line)
- The tag will trigger a travis build. At the end of the travis build, two
  deployment steps follow (only on tag)
  - upload all conda packages to the anaconda cloud
  - trigger a build on quay.io 
- Once the deployment steps have finished and the docker image has been built on quay
  you can:
  - use ```conda install -c bc-dev xcube``` to install xcube in a conda environment
  - user docker image ```quay.io/dzelge/xcube:[version]``` e.g.  ```docker pull quay.io/dzelge/xcube:[version]```

TODO: Change the quay repo and travis accounts and setup the deploy key accordingly  

    
## Usage for conda images

```bash

conda install -c bc-dev xcube[=version]
# OR
conda create pn xcube -c bc-dev xcube[=version]

```

Or use specify the xcube package in an ```environment.yml```.


## Usage for Docker images

TODO: Describe how to not be a root user in the docker container

Use the docker quay.io image. The container exposes port 8000 by default and runs
bash in an xcube conda environment. 

```bash
docker pull quay.io/dzelge/xcube:[version]
docker run quay.io/dzelge/xcube:[version]

(xcube)#:
```

The following example uses the image in a ```docker-compose.yml``` to start
an xcube server. 

```yaml
version: '3'
services:
example-server:
  entrypoint: ""
  command: "source activate xcube && xcube serve -n example --prefix 'api/v1.dev' -p 8000 -v -u 30 -c /example/server-config.yml --traceperf"
  image: quay.io/dzelge/xcube:[version]
  restart: always
  ports:
    - "0.0.0.0:[port]:8000"
  volumes:
    - .:/example
```

Start the server with:

```bash
docker-compose up -d
```

# Technologies and Services

- conda
  - packages deployed to linux-64, win-64, osx-64 using conda convert
- [anaconda.org](https://anaconda.org/bc-dev/xcube)
- [travis-ci.org](https://travis-ci.com/dcs4cop/xcube-conda) 
- docker / docker-compose
- [quay.io](https://quay.io/repository/bcdev/xcube)

## Dependencies

- Can be run using python 3.6 and 3.7 and numpy 1.16
- For all dependencies for the conda images see [meta.yaml](xcube/meta.yaml)


