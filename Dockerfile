FROM node:lts as builder

RUN apt update && apt install -y openjdk-8-jre busybox

RUN wget https://github.com/GitaiQAQ/unpkg.com/archive/dev.zip && unzip *.zip

WORKDIR /unpkg.com-dev

RUN echo "export default (_, res) => res.status(404).send('Sorry, Self hosting without stats!');" > modules/actions/serveStats.js

RUN npm install && npm run build

FROM node:lts-alpine

MAINTAINER Gitai<i@gitai.me>

WORKDIR /root

COPY --from=builder /unpkg.com-dev/public /unpkg.com-dev/package.json /unpkg.com-dev/server.js /root/

RUN npm install --production

ENTRYPOINT ["node", "/root/server.js"]
