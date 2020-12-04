FROM quay.io/ibmz/ubuntu:20.04

COPY . /

RUN apt-get update && apt-get install nodejs npm vim wget git lsb-core autoconf libpng-dev software-properties-common curl -y && \
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
  /node_modules/yarn/bin/yarn && \
  /node_modules/yarn/bin/yarn start 
