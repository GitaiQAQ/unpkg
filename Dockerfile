FROM node:lts as builder

RUN apt update && apt install -y openjdk-8-jre busybox

WORKDIR /root

RUN wget https://github.com/GitaiQAQ/unpkg.com/archive/dev.zip && unzip *.zip

RUN pwd && cd /unpkg.com-* && ls . && echo "export default (_, res) => res.status(404).send('Sorry, Self hosting without stats!');" > modules/actions/serveStats.js

RUN pwd && cd /unpkg.com-* && npm install && npm run build

FROM node:lts-alpine

MAINTAINER Gitai<i@gitai.me>

COPY --from=builder unpkg.com-*/public unpkg.com-*/package.json unpkg.com-*/server.js ~/

RUN cd ~ && npm install --production

ENTRYPOINT ["node", "/root/server.js"]
