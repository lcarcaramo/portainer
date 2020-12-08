FROM quay.io/ibmz/ubuntu:20.04

COPY . /

RUN apt-get update && \
    export DEBIAN_FRONTEND=noninteractive \
    && export DEBCONF_NONINTERACTIVE_SEEN=true \
    && echo 'tzdata tzdata/Areas select Etc' | debconf-set-selections \
    && echo 'tzdata tzdata/Zones/Etc select UTC' | debconf-set-selections && \
  apt-get update && apt-get install nodejs dialog npm vim wget git lsb-core autoconf libpng-dev software-properties-common curl -y && \
  echo "DEBUG A" && \
  npm install mime-types && \
  echo "DEBUG B" && \
  npm install yarn && \
  #vi installgo.sh && \
  chmod a+x installgo.sh && \
  ./installgo.sh && \
  #vi adddocker.sh && \
  chmod a+x adddocker.sh && \
  ./adddocker.sh && \
  git clone https://github.com/portainer/portainer.git && \
  mkdir -p ${GOPATH}/src/github.com/portainer && \
  ln -s ${PWD}/portainer ${GOPATH}/src/github.com/portainer && \
  cd portainer/ && \
  ln -s /usr/local/go//bin/go /usr/bin/go && \
  /node_modules/yarn/bin/yarn
#  /node_modules/yarn/bin/yarn start 
