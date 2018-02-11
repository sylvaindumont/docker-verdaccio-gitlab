FROM node:8-alpine

ENV NODE_ENV production

RUN npm config set registry http://registry.npmjs.org/ && \
    npm install -g verdaccio@2.7.4 && \
    npm install -g verdaccio-gitlab@latest && \
    npm cache -g clear --force && \
    mkdir -p /verdaccio/storage /verdaccio/conf

ADD https://raw.githubusercontent.com/verdaccio/verdaccio/master/conf/docker.yaml /verdaccio/conf/config.yaml

USER node

VOLUME ["/verdaccio/storage"]

CMD ["verdaccio", "--config", "/verdaccio/conf/config.yaml", "--listen", "http://0.0.0.0:4873"]
