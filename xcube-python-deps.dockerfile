ARG XCUBE_VERSION

FROM quay.io/bcdev/xcube-python-base:${XCUBE_VERSION}

ARG XCUBE_VERSION
ARG XCUBE_DOCKER_BRANCH
ARG XCUBE_USER_NAME


LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name="xcube python dependencies"
LABEL xcube_version=${XCUBE_VERSION}
LABEL XCUBE_DOCKER_BRANCH=${XCUBE_DOCKER_BRANCH}


USER ${XCUBE_USER_NAME}

RUN whoami
RUN conda create -n xcube -c conda-forge xcube=${XCUBE_VERSION}
RUN conda clean -afy
RUN conda info --envs
RUN source activate xcube && conda list

RUN echo "conda activate xcube" >> ~/.bashrc

CMD ["/bin/bash"]