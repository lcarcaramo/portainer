FROM quay.io/ibmz/ubuntu:18.04

#WORKDIR /home/travis/build/YBA-IBM/portainer
COPY . /

ARG NODEJS_HOME=/opt/nodejs

ENV HOME=/tmp \
    NODEJS_HOME=${NODEJS_HOME} \
    NODEJS_VERSION=v10.23.0 \
    PATH=${NODEJS_HOME}/bin:${PATH} \
    NODE_PATH=${NODEJS_HOME}/lib/node_modules \
    SRC_PATH=/usr/src

RUN apt-get update && \
        apt-get remove -y cmdtest && \
        #apt-get install -y nodejs && \
        apt-get install -y curl && \
        apt-get install -y wget && \
        apt-get install -y gpg && \
        #
        #curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh && \
        #curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
        #bash nodesource_setup.sh && \
        #apt-get install -y nodejs && \
        && curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.xz" \
        && curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
        && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
        && grep " node-v$NODE_VERSION.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
        && tar -xf "node-v$NODE_VERSION.tar.xz" \
        && cd "node-v$NODE_VERSION" \
        echo "NODEJS VERSION FROM OUR ATTEMPT AT 10.23.0:" && nodejs -v && \
        #
        apt-get install -y npm && \
        npm install yarn -g && \
        #apt-get install -y yarn && \
        #apt-get install -y golang-stable && \
        #
        echo "DEBUG A" && pwd && ls && \
        mkdir temp                                                      && \
        cd temp                                                        && \
        wget https://dl.google.com/go/go1.15.5.linux-amd64.tar.gz       && \
        tar -xvf go1.15.5.linux-amd64.tar.gz                            && \
        mv go /usr/local                                                && \
        export GOROOT=/usr/local/go                                     && \
        export GOPATH=$HOME/go                                          && \
        export PATH=$GOPATH/bin:$GOROOT/bin:$PATH                       && \
        #
        echo "DEBUG B" && pwd && ls && echo "DEBUG C" && cd .. && pwd && ls        &&\
        mkdir -p ${GOPATH}/src/github.com/portainer                             && \
        ln -s ${PWD} ${GOPATH}/src/github.com/portainer/portainer     && \
        #
        #yarn config set ignore-engines true                             && \
        yarn                                                            && \
        yarn start                                                      

