FROM node:lts-alpine

MAINTAINER Gitai<i@gitai.me>

RUN wget -qO- https://github.com/unpkg/unpkg.com/archive/master.zip | busybox unzip - 

RUN cd unpkg.com-master && yarn && yarn run build
