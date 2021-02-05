ARG XCUBE_VERSION

FROM quay.io/bcdev/xcube:${XCUBE_VERSION}

ARG XCUBE_VERSION
ARG XCUBE_SH_VERSION
ARG XCUBE_CCI_VERSION
ARG XCUBE_CDS_VERSION
ARG XCUBE_USER_NAME

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name=XCUBE_GEN
LABEL xcube_version=${XCUBE_VERSION}
LABEL jupyterlab_version=${JUPYTERLAB_VERSION}

RUN echo "Building docker using args:"
RUN echo "XCUBE_VERSION:${XCUBE_VERSION}"
RUN echo "XCUBE_USER_NAME:${XCUBE_USER_NAME}"

USER ${XCUBE_USER_NAME}

RUN source activate xcube && mamba install -y -c conda-forge xcube-sh=${XCUBE_SH_VERSION}
RUN source activate xcube && mamba install -y -c conda-forge xcube-cci=${XCUBE_CCI_VERSION}
RUN source activate xcube && mamba install -y -c conda-forge xcube-cds=${XCUBE_CDS_VERSION}

ADD resources/edc-store-config.yml edc-store-config.yml

CMD ["/bin/bash"]