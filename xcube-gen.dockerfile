ARG XCUBE_VERSION

FROM quay.io/bcdev/xcube:${XCUBE_VERSION}

ARG XCUBE_VERSION
ARG XCUBE_SH_VERSION
ARG XCUBE_SH_INSTALL_MODE='github'
ARG XCUBE_CCI_VERSION
ARG XCUBE_CCI_INSTALL_MODE='github'
ARG XCUBE_CDS_VERSION
ARG XCUBE_CDS_INSTALL_MODE='github'
ARG XCUBE_USER_NAME

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name=XCUBE_GEN
LABEL xcube_version=${XCUBE_VERSION}
LABEL jupyterlab_version=${JUPYTERLAB_VERSION}

RUN echo "Building docker using args:"
RUN echo "XCUBE_VERSION:${XCUBE_VERSION}"
RUN echo "XCUBE_USER_NAME:${XCUBE_USER_NAME}"

USER ${XCUBE_USER_NAME}

WORKDIR /tmp

ADD scripts/install_xcube-datastore.sh .

RUN bash install_xcube-datastore.sh xcube-sh ${XCUBE_SH_VERSION} ${XCUBE_SH_INSTALL_MODE}
RUN bash install_xcube-datastore.sh xcube-cci ${XCUBE_CCI_VERSION} ${XCUBE_CCI_INSTALL_MODE}
RUN bash install_xcube-datastore.sh xcube-cds ${XCUBE_CDS_VERSION} ${XCUBE_CDS_INSTALL_MODE}

RUN source activate xcube && mamba install -c conda-forge s3fs
WORKDIR /home/${XCUBE_USER_NAME}

CMD ["/bin/bash"]