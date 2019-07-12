# Image from https://hub.docker.com (syntax: repo/image:version)
FROM continuumio/miniconda3:latest

# Person responsible
MAINTAINER helge.dzierzon@brockmann-consult.de

LABEL name=xcube
LABEL version=0.2.0.dev2

# Ensure usage of bash (simplifies source activate calls)
SHELL ["/bin/bash", "-c"]

# Update system and install dependencies
RUN apt-get -y update && apt-get -y upgrade

RUN conda create -n xcube -c conda-forge -c bc-dev xcube

RUN echo "conda activate xcube" >> ~/.bashrc
# Export web server port 8000
EXPOSE 8000

# Start server
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["xcube"]