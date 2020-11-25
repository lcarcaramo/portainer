FROM portainer/base
RUN ls
COPY dist /
VOLUME /data
WORKDIR /
EXPOSE 9000

ENTRYPOINT ["/portainer"]
