ARG XCUBE_GEODB_POSTGREST_VERSION

FROM postgrest/postgrest:${XCUBE_GEODB_POSTGREST_VERSION}

ARG XCUBE_GEODB_RESTAPI_DOCKER_VERSION
ARG XCUBE_GEODB_POSTGREST_VERSION

LABEL geodb_server_version=XCUBE_GEODB_RESTAPI_DOCKER_VERSION
LABEL geodb_postgrest_version=XCUBE_GEODB_POSTGREST_VERSION
LABEL maintainer=helge.dzierzon@brockmann-consult.de

USER root

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y psmisc

USER postgrest
