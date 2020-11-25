FROM quay.io/ibmz/alpine:3.12 as base
RUN apk --no-cache --update upgrade && apk --no-cache add ca-certificates
RUN echo "Debug 0"

FROM scratch
RUN echo "Debug 1"
RUN pwd && ls
COPY --from=base /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
RUN echo "Debug 2"
RUN pwd && ls
