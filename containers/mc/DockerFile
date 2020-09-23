FROM alpine:latest
ARG BUILD_DATE
LABEL build_version="4E71-NOP Build-date:- ${BUILD_DATE}"
RUN apk add openssh mc --no-cache
ENTRYPOINT ["/usr/bin/mc"]
