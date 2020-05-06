ARG MINICONDA_VERSION

FROM continuumio/miniconda3:${MINICONDA_VERSION}
ARG XCUBE_VERSION
ARG XCUBE_USER_NAME

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name="XCUBE python miniconda base"
LABEL XCUBE_version=${XCUBE_VERSION}

RUN echo "Building docker using args:"
RUN echo "XCUBE_VERSION:${XCUBE_VERSION}"
RUN echo "XCUBE_USER_NAME:${XCUBE_USER_NAME}"

USER root
RUN apt-get -y update && apt-get -y install vim

SHELL ["/bin/bash", "-c"]
RUN groupadd -g 1000 ${XCUBE_USER_NAME}
RUN useradd -u 1000 -g 1000 -ms /bin/bash ${XCUBE_USER_NAME}
RUN mkdir /workspace && chown ${XCUBE_USER_NAME}.${XCUBE_USER_NAME} /workspace
RUN chown -R ${XCUBE_USER_NAME}.${XCUBE_USER_NAME} /opt/conda

USER ${XCUBE_USER_NAME}

WORKDIR /workspace

RUN source activate base && conda update -n base conda && conda init

CMD ["/bin/bash"]