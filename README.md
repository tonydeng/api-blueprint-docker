# API Blueprint Docker

[![Docker Stars](https://img.shields.io/docker/stars/wolfdeng/api-blueprint-docker.svg)](https://hub.docker.com/r/wolfdeng/api-blueprint-docker/)
[![Docker Pulls](https://img.shields.io/docker/pulls/wolfdeng/api-blueprint-docker.svg)](https://hub.docker.com/r/wolfdeng/api-blueprint-docker/)
[![Image Size](https://img.shields.io/imagelayers/image-size/wolfdeng/api-blueprint-docker/latest.svg)](https://imagelayers.io/?images=wolfdeng/api-blueprint-docker:latest)
[![Image Layers](https://img.shields.io/imagelayers/layers/wolfdeng/api-blueprint-docker/latest.svg)](https://imagelayers.io/?images=wolfdeng/api-blueprint-docker:latest)

本Docker Image提供了三个服务。

1. API Blueprint Document Server，基于[Nginx](https://github.com/nginx/nginx) + [Aglio](https://github.com/danielgtaylor/aglio)
1. API Blueprint Mock Server，基于[Drakov](https://github.com/Aconex/drakov)
1. API Blueprint Document Server和Mock Server在Docker容器内部更新的Webhook，基于[Nodejs](https://nodejs.org/)


## 获取镜像

```bash
docker pull wolfdeng/api-blueprint-docker
```

查看镜像详细信息 [https://hub.docker.com/r/wolfdeng/api-blueprint-docker/](https://hub.docker.com/r/wolfdeng/api-blueprint-docker/)

## 启动

### 指定API Blueprint文档Git公有仓库

```bash
docker run --name api-blueprint -e "repository={repository}" -p 80:80 -p 8080:8080 -p 3000:3000 -d wolfdeng/api-blueprint-docker
```

> 通过 -e "repository={repository}" 来指定仓库，具体使用时替换{repository}为正式仓库地址即可。

### 指定API Blueprint文档Git私有仓库

```bash
docker run --name api-blueprint-test -v ~/.ssh:/root/.ssh -e "repository={repository}" -p 80:80 -p 8080:8080 -p 3000:3000 -d wolfdeng/api-blueprint-docker
```

> 通过 -v ~/.ssh:/root/.ssh 来讲本地的private key映射到Docker容器中的ROOT账号

### 指定本地API Blueprint文档目录

```bash
docker run --name api-blueprint-test -v ${api-blueprint-path}:/opt/api-blueprint -p 80:80 -p 8080:8080 -p 3000:3000 -d wolfdeng/api-blueprint-docker
```

### 指定API Blueprint文档模板风格

```bash
docker run --name api-blueprint -e "aglio=--theme-template triple" -e "repository={repository}" -p 80:80 -p 8080:8080 -p 3000:3000 -d wolfdeng/api-blueprint-docker
```

> 通过 -e "aglio=--theme-template triple" 来指定aglio生成HTML的风格，比如现在指定的就是"triple"。更多aglio相应内容可以查看[Aglio文档](https://github.com/danielgtaylor/aglio#executable)

## 使用Webhook

* 可以简单使用CURL来进行Webhook调用

```bash
curl http://localhost:8080
```

* 可以在Git托管服务上指定Webhook地址
