FROM quay.io/ibmz/alpine:3.12 as base
RUN pwd && ls
RUN apk --no-cache --update upgrade && apk --no-cache add ca-certificates
RUN pwd && ls

FROM scratch
COPY --from=base /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
HEALTHCHECK CMD pwd
RUN pwd && ls
