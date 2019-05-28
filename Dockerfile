FROM node:8.16.0-alpine

MAINTAINER Gitai<i@gitai.me>

RUN git clone https://github.com/unpkg/unpkg.com.git --depth=1
