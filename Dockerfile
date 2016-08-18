FROM centos

RUN yum install -y epel-release && yum update -y && yum install node npm make nginx git

RUN npm install g aglio drakov

COPY scripts/deploy.sh /usr/local/bin/
COPY scripts/startup.sh /usr/local/bin/
COPY scripts/webhook.js /usr/local/bin/

RUN chmod -R 755 /usr/local/bin/*

CMD /usr/local/bin/deploy && /usr/local/bin/startup.sh
