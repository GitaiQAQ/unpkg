FROM node:lts as builder

RUN apt update && apt install -y openjdk-8-jre busybox

RUN wget -qO- https://github.com/unpkg/unpkg.com/archive/master.zip | busybox unzip - 

RUN cd unpkg.com-master && npm install && npm run build

FROM node:lts-alpine

MAINTAINER Gitai<i@gitai.me>

COPY --from=builder /root/unpkg.com-master .

ENTRYPOINT ["node", "/root/server.js"]
