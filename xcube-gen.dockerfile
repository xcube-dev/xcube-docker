FROM tiangolo/uwsgi-nginx-flask:python3.7

ARG XCUBE_VERSION

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name=XCUBE
LABEL xcube_version=${XCUBE_VERSION}

RUN echo "Building docker using args: "
RUN echo "XCUBE_VERSION:${XCUBE_VERSION}"

ADD . /xcube-gen
WORKDIR /xcube-gen
RUN pip install pyyaml
RUN python xcube_gen/resources/conv-env.py
RUN pip install -r requirements.txt
RUN python setup.py install

RUN rm -rf /app && cp -r /xcube-gen /app
WORKDIR /app
RUN mv xcube_gen/resources/uwsgi.ini .
