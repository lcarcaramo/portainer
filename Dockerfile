FROM quay.io/ibmz/ubuntu:20.04
COPY installgo.sh .
COPY adddocker.sh .
RUN export DEBIAN_FRONTEND=noninteractive \
    && export DEBCONF_NONINTERACTIVE_SEEN=true \
    && echo 'tzdata tzdata/Areas select Etc' | debconf-set-selections \
    && echo 'tzdata tzdata/Zones/Etc select UTC' | debconf-set-selections \
    && apt-get update && apt-get install nodejs npm vim wget git lsb-core autoconf libpng-dev software-properties-common curl -y \
    && npm install yarn \
    && chmod a+x installgo.sh \
    && ./installgo.sh \
    && chmod a+x adddocker.sh \
    && ./adddocker.sh \
    && git clone https://github.com/portainer/portainer.git \
    && mkdir -p ${GOPATH}/src/github.com/portainer \
    && ln -s ${PWD}/portainer ${GOPATH}/src/github.com/portainer \
    && cd portainer/ \
    && ln -s /usr/local/go/bin/go /usr/bin/go
WORKDIR /portainer
RUN /node_modules/yarn/bin/yarn
ENTRYPOINT ["/node_modules/yarn/bin/yarn", "start"]
