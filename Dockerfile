FROM quay.io/ibmz/ubuntu:18.04

RUN apt-get update && 
        apt remove -y cmdtest && \
        apt-get install -y nodejs && \
        apt-get install -y yarn && \
        apt-get install -y wget && \
        #apt-get install -y golang-stable && \
        #
        mkdir temp                                                      && \
        cd /temp                                                        && \
        wget https://dl.google.com/go/go1.15.5.linux-amd64.tar.gz       && \
        tar -xvf go1.15.5.linux-amd64.tar.gz                            && \
        mv go /usr/local                                                && \
        export GOROOT=/usr/local/go                                     && \
        export GOPATH=$HOME/go                                          && \
        export PATH=$GOPATH/bin:$GOROOT/bin:$PATH                       && \
        #
        mkdir -p ${GOPATH}/src/github.com/portainer                             && \
        ln -s ${PWD} ${GOPATH}/src/github.com/portainer/portainer     && \
        yarn                                                            && \
        yarn start                                                      

