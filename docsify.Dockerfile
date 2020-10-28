FROM node:lts-alpine

ARG DEFAULT_CLI_VERSION=4.4.1
ARG DEFAULT_EXPOSE=3000

ENV CLI_VERSION $DEFAULT_CLI_VERSION
ENV PORT $DEFAULT_EXPOSE

EXPOSE $PORT/tcp

RUN apk update \
    && apk add openssh \
    && apk add git

RUN npm i docsify-cli@$CLI_VERSION -g; \
    npm list -g --depth=0;

RUN mkdir -p /root/.ssh \
    && ssh-keyscan github.com > /root/.ssh/known_hosts

WORKDIR /var/www

COPY . .

ENTRYPOINT ["sh", "./entrypoint.sh"]

CMD docsify serve ./docs -p $PORT