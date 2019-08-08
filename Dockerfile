# Image from https://hub.docker.com (syntax: repo/image:version)
FROM continuumio/miniconda3:latest

# Person responsible
LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name=xcube
ARG XCUBE_VERSION="0.2.0dev3"
LABEL version=${XCUBE_VERSION}

# Ensure usage of bash (simplifies source activate calls)
SHELL ["/bin/bash", "-c"]

# Update system and install dependencies
RUN apt-get -y update && apt-get -y upgrade

RUN conda create -n xcube -c conda-forge -c bc-dev xcube=${XCUBE_VERSION}

RUN echo "conda activate xcube" >> ~/.bashrc
# Export web server port 8000
EXPOSE 8000

# Start server
ENTRYPOINT ["bash"]
