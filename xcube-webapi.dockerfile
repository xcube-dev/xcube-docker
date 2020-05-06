ARG XCUBE_VERSION

FROM quay.io/bcdev/xcube-python-deps:${XCUBE_VERSION}

ARG XCUBE_VERSION
ARG XCUBE_USER_NAME

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name=xcube
LABEL xcube_version=${XCUBE_VERSION}

RUN echo "Building docker using args:"
RUN echo "XCUBE_VERSION:${XCUBE_VERSION}"
RUN echo "XCUBE_USER_NAME:${XCUBE_USER_NAME}"

USER ${XCUBE_USER_NAME}

CMD ["/bin/bash", "-c", "source activate xcube && xcube -v -p 4000 -a 0.0.0.0"]