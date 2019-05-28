FROM node:lts as builder

RUN apt update && apt install -y openjdk-8-jre busybox

RUN wget https://github.com/unpkg/unpkg.com/archive/master.zip && unzip master.zip

RUN cd unpkg.com-master && npm install && npm run build

FROM node:lts-alpine

MAINTAINER Gitai<i@gitai.me>

COPY --from=builder unpkg.com-master .

ENTRYPOINT ["node", "/root/server.js"]
