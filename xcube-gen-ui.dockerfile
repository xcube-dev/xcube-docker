ARG XCUBE_GEN_VERSION

FROM quay.io/bcdev/xcube-gen-ui:${XCUBE_GEN_VERSION} as ui

ARG XCUBE_GEN_VERSION
ARG XCUBE_VIEWER_VERSION
ARG XCUBE_USER_NAME

MAINTAINER helge.dzierzon@brockmann-consult.de

LABEL software=xcube-gen-ui
LABEL xcube-gen-version=${XCUBE_GEN_VERSION}
LABEL xcube-viewer-version=${XCUBE_VIEWER_VERSION}

WORKDIR /usr/src/app

FROM quay.io/bcdev/xcube-gen-viewer:${XCUBE_VIEWER_VERSION} as viewer

# Stage 2 - the production environment
FROM nginx:1.12-alpine
COPY --from=ui /usr/src/app/build /usr/share/nginx/html
COPY --from=viewer /usr/src/app/build /usr/share/nginx/html/viewer
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
