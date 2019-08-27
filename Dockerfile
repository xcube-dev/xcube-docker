# Image from https://hub.docker.com (syntax: repo/image:version)
FROM continuumio/miniconda3:latest

# Person responsible
LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name=xcube
ARG XCUBE_VERSION="0.2.0.dev1"
LABEL version=${XCUBE_VERSION}

# Ensure usage of bash (simplifies source activate calls)
SHELL ["/bin/bash", "-c"]

# Update system and install dependencies
RUN apt-get -y update && apt-get -y upgrade

RUN conda create -n xcube -c conda-forge -c bc-dev xcube=${XCUBE_VERSION}

RUN groupadd -g 1000 xcube
RUN useradd -u 1000 -g 1000 -ms /bin/bash xcube
USER xcube

RUN echo "conda activate xcube" >> ~/.bashrc

