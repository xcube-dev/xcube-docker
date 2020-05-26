ARG XCUBE_VERSION

FROM quay.io/bcdev/xcube-python-base:${XCUBE_VERSION}

ARG XCUBE_VERSION
ARG XCUBE_USER_NAME


LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name="xcube python dependencies"
LABEL xcube_version=${XCUBE_VERSION}

RUN echo "Building docker using args:"
RUN echo "XCUBE_VERSION:${XCUBE_VERSION}"
RUN echo "XCUBE_USER_NAME:${XCUBE_USER_NAME}"

USER ${XCUBE_USER_NAME}

RUN whoami
RUN mamba create -y -n xcube -c conda-forge xcube=${XCUBE_VERSION}
RUN conda info --envs
RUN source activate xcube && conda list

RUN echo "conda activate xcube" >> ~/.bashrc

CMD ["/bin/bash"]