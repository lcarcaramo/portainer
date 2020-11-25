FROM quay.io/ibmz/alpine:3.12
COPY dist /
VOLUME /data
WORKDIR /
EXPOSE 9000

ENTRYPOINT ["/portainer"]
