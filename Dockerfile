#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  API Blueprint container
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

FROM centos:6.9

COPY scripts/* /usr/local/bin/

RUN chmod -R 755 /usr/local/bin/* \
  # 将centos默认源更换成阿里云的源
  && yum install -y wget \
  && mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup \
  && wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo \
  && yum clean all \
  && yum makecache \
  # 安装epel-release，并将其默认源更换成阿里云的源
  && yum install -y epel-release \
  && mv /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.backup \
  && mv /etc/yum.repos.d/epel-testing.repo /etc/yum.repos.d/epel-testing.repo.backup \
  && wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-6.repo \
  && yum update -y \
  # 安装开发环境需要的软件
  && yum install -y \
    make \
    nginx \
    git \
    zsh \
  # 安装 oh-my-zsh
  && sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" \
  && chsh -s /bin/zsh \
  # 安装 nvm
  && wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash \
  && export NVM_DIR=~/.nvm \
  && source ~/.nvm/nvm.sh \
  && source ~/.bash* \
  # 安装  node
  && nvm install stable \
  && node -v \
  && npm -v \
  # 安装 nrm
  && npm install -g nrm --registry=https://registry.npm.taobao.org \
  && nrm use cnpm \
  # 安装必要前端环境
  # 添加 --unsafe-perm --verbose 参数的原因：https://github.com/nodejs/node-gyp/issues/454
  && npm install --unsafe-perm --verbose -g \
    webpack \
    webpack-dev-server \
    gulp \
    aglio \
    drakov \
  # yum 清除缓存
  && yum clean all \
  # npm 清除缓存
  && npm cache clean --force

CMD ["/usr/local/bin/deploy.sh", "/usr/local/bin/startup.sh", "zsh"]
