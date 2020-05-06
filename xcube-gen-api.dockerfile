FROM tiangolo/uwsgi-nginx-flask:python3.7

ARG XCUBE_GEN_VERSION
ARG XCUBE_VERSION

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name=xcube-gen-api
LABEL xcube_gen_version=${XCUBE_GEN_VERSION}
LABEL xcube_version=${XCUBE_VERSION}

RUN echo "Building docker using args: "
RUN echo "XCUBE_GEN_VERSION:${XCUBE_GEN_VERSION}"
RUN echo "XCUBE_VERSION:${XCUBE_VERSION}"

RUN rm -rf /app
RUN git clone https://github.com/dcs4cop/xcube-gen /app
WORKDIR /app

COPY ./scripts/wsgi.py ./xcube_gen/wsgi.py
COPY ./scripts/uwsgi.ini ./uwsgi.ini
COPY ./scripts/conv-env.py ./conv-env.py

RUN pip install pyyaml awscli
RUN python conv-env.py
RUN pip install -r requirements.txt
RUN python setup.py install

