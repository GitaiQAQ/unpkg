FROM node:lts-alpine

MAINTAINER Gitai<i@gitai.me>

RUN apk add --no-cache --update openjdk8-jre

RUN wget -qO- https://github.com/unpkg/unpkg.com/archive/master.zip | busybox unzip - 

RUN cd unpkg.com-master && npm install && npm run build
