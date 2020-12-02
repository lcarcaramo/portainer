FROM quay.io/ibmz/ubuntu:18.04

#WORKDIR /home/travis/build/YBA-IBM/portainer
COPY . /

RUN apt-get update && \
        apt-get remove -y cmdtest && \
        #apt-get install -y nodejs && \
        apt-get install -y curl && \
        #
        #curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh && \
        curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
        #bash nodesource_setup.sh && \
        apt-get install -y nodejs && \
        #
        #
        apt-get install -y npm && \
        npm install yarn -g && \
        #apt-get install -y yarn && \
        apt-get install -y wget && \
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

