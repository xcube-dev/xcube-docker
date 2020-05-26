FROM node:stretch-slim as build-deps

ARG XCUBE_VERSION
ARG XCUBE_USER_NAME

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name=xcube
LABEL xcube_version=${XCUBE_VERSION}

RUN echo "Building docker using args:"
RUN echo "XCUBE_VERSION:${XCUBE_VERSION}"
RUN echo "XCUBE_USER_NAME:${XCUBE_USER_NAME}"

RUN apt-get -y update && apt-get install -y git

RUN git clone https://github.com/dcs4cop/xcube-viewer /usr/src/app
WORKDIR /usr/src/app

RUN yarn install --network-concurrency 1 --network-timeout 1000000

RUN yarn build
RUN yarn global add serve

CMD ["bash", "-c", "serve -l 80 -d -s build"]

