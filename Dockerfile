FROM node:lts as builder

RUN apt update && apt install -y openjdk-8-jre busybox

RUN wget https://github.com/unpkg/unpkg.com/archive/master.zip && unzip master.zip

RUN echo "export default null;" > unpkg.com-master/modules/actions/serveStats.js

RUN cd unpkg.com-master && npm install && npm run build

FROM node:lts-alpine

MAINTAINER Gitai<i@gitai.me>

COPY --from=builder unpkg.com-master/package.json unpkg.com-master/server.js /root/

RUN npm install --production

ENTRYPOINT ["node", "/root/server.js"]
