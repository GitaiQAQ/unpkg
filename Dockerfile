FROM node:lts as builder

RUN apt update && apt install -y openjdk-8-jre busybox

RUN wget https://github.com/GitaiQAQ/unpkg.com/archive/dev.zip && unzip *.zip && cd unpkg.com-*

RUN pwd && ls . && echo "export default (_, res) => res.status(404).send('Sorry, Self hosting without stats!');" > modules/actions/serveStats.js

RUN npm install && npm run build

FROM node:lts-alpine

MAINTAINER Gitai<i@gitai.me>

COPY --from=builder unpkg.com-*/package.json unpkg.com-*/server.js /root/

RUN cd ~ && npm install --production

ENTRYPOINT ["node", "/root/server.js"]
