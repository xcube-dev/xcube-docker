[![Build Status](https://travis-ci.com/dcs4cop/xcube-docker.svg?branch=master)](https://travis-ci.com/dcs4cop/xcube-docker)

## Description

The docker images that are hosted on quay.io use the conda forge package xcube.
In order to update the docker images to a new xcube version, follow these steps:

- Update the xcube version in Dockerfile
- Push the changes and review new build on quay.io
- When the build is successful, test the image locally
- When teh local test is successful, create a version release/tag which should be the same as the xcube version
- The tag will trigger a quay build. Quay will set the docker image version according to the used
  xcube version/release tag
- Once the deployment steps have finished and the docker image has been built on quay
  you can use the docker image ```quay.io/dzelge/xcube:[version]``` by e.g.
  ```docker run quay.io/dzelge/xcube:[version]```


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
- [conda-forge.org](https://conda-forge.org/)
- [travis-ci.org](https://travis-ci.com/dcs4cop/xcube-conda) 
- docker / docker-compose
- [quay.io](https://quay.io/repository/dzelge/xcube)

## Dependencies

- Can be run using python >= 3.6



