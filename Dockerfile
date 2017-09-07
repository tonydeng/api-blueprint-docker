FROM ubuntu

## Update system

RUN ap-get update -y

## Install package
RUN apt-get install -y npm git nginx nodejs-legacy
RUN npm install -g aglio drakov

COPY scripts/* /usr/local/bin/

RUN chmod -R 755 /usr/local/bin/*

CMD /usr/local/bin/deploy.sh && /usr/local/bin/startup.sh

#Clear
RUN apt-get clean && rm -rf /var/cache/apt-archives/* /var/lib/apt/lists/*
