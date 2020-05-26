ARG XCUBE_VERSION

FROM quay.io/bcdev/xcube:${XCUBE_VERSION}

ARG XCUBE_VERSION
ARG XCUBE_USER_NAME
ARG JUPYTERLAB_VERSION

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name=XCUBE
LABEL xcube_version=${XCUBE_VERSION}
LABEL jupyterlab_version=${JUPYTERLAB_VERSION}

RUN echo "Building docker using args:"
RUN echo "XCUBE_VERSION:${XCUBE_VERSION}"
RUN echo "XCUBE_USER_NAME:${XCUBE_USER_NAME}"
RUN echo "JUPYTERLAB_VERSION:${JUPYTERLAB_VERSION}"

USER ${XCUBE_USER_NAME}

RUN conda install jupyterlab=${JUPYTERLAB_VERSION}

EXPOSE 8888

CMD ["/bin/bash", "-c", "source activate xcube && jupyterlab --ip 0.0.0.0"]