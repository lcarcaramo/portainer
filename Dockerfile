FROM quay.io/ibmz/ubuntu:18.04

#WORKDIR /home/travis/build/YBA-IBM/portainer
COPY . /

ARG NODEJS_HOME=/opt/nodejs

ENV HOME=/tmp \
    NODEJS_HOME=${NODEJS_HOME} \
    NODEJS_VERSION=v10.23.0 \
    NODE_VERSION=10.23.0 \
    PATH=${NODEJS_HOME}/bin:${PATH} \
    NODE_PATH=${NODEJS_HOME}/lib/node_modules \
    SRC_PATH=/usr/src

RUN apt-get update && \
        apt-get remove -y cmdtest && \
        #apt-get install -y nodejs && \
        apt-get install -y curl && \
        apt-get install -y wget && \
        apt-get install -y gpg && \
        apt-get install xz-utils && \
        #
        #curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh && \
        #curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
        #bash nodesource_setup.sh && \
        #apt-get install -y nodejs && \
        #
        #curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.xz" && \
        #echo "DEBUG CURL" && \
        #curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" && \
        #gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc && \
        #grep " node-v$NODE_VERSION.tar.xz\$" SHASUMS256.txt | sha256sum -c - && \
        #tar -xf "node-v$NODE_VERSION.tar.xz" && \
        #cd "node-v$NODE_VERSION" && \
        #
        wget -U "nodejs" -q -O node-${NODEJS_VERSION}-linux-s390x.tar.xz https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}-linux-s390x.tar.xz && \
        wget -U "nodejs" -q -O SHASUMS256.txt https://nodejs.org/dist/${NODEJS_VERSION}/SHASUMS256.txt && \
        wget -U "nodejs" -q -O SHASUMS256.txt.sig https://nodejs.org/dist/${NODEJS_VERSION}/SHASUMS256.txt.sig && \
        gpg --keyserver pool.sks-keyservers.net --recv-keys DD8F2338BAE7501E3DD5AC78C273792F7D83545D && \
        gpg --keyserver pool.sks-keyservers.net --recv-keys 4ED778F539E3634C779C87C6D7062848A1AB005C && \
        gpg --keyserver pool.sks-keyservers.net --recv-keys 94AE36675C464D64BAFA68DD7434390BDBE9B9C5 && \
        gpg --keyserver pool.sks-keyservers.net --recv-keys 71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 && \
        gpg --keyserver pool.sks-keyservers.net --recv-keys 8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600 && \
        gpg --keyserver pool.sks-keyservers.net --recv-keys C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 && \
        gpg --keyserver pool.sks-keyservers.net --recv-keys C82FA3AE1CBEDC6BE46B9360C43CEC45C17AB93C && \
        gpg --keyserver pool.sks-keyservers.net --recv-keys DD8F2338BAE7501E3DD5AC78C273792F7D83545D && \
        gpg --keyserver pool.sks-keyservers.net --recv-keys A48C2BEE680E841632CD4E44F07496B3EB3C1762 && \
        gpg --keyserver pool.sks-keyservers.net --recv-keys 108F52B48DB57BB0CC439B2997B01419BD92F80A && \
        gpg --keyserver pool.sks-keyservers.net --recv-keys B9E2F5981AA6E0CD28160D9FF13993A75599653C && \
        gpg --verify SHASUMS256.txt.sig SHASUMS256.txt && \
        grep node-${NODEJS_VERSION}-linux-s390x.tar.xz SHASUMS256.txt | sha256sum -c - && \
        tar Jxf node-${NODEJS_VERSION}-linux-s390x.tar.xz --no-same-owner && \
        rm node-${NODEJS_VERSION}-linux-s390x.tar.xz SHASUMS256.txt SHASUMS256.txt.sig /tmp/.gnupg/pubring.kbx /tmp/.gnupg/trustdb.gpg && \
        mv node-${NODEJS_VERSION}-linux-s390x ${NODEJS_HOME} && \
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

