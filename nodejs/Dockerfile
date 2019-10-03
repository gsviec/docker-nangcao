# vim:set ft=dockerfile:
FROM node:10.15.0-alpine
ENV PROJECT_DIR="/app"
RUN (if ! test -d $PROJECT_DIR; then mkdir -p $PROJECT_DIR ; fi) && \
(if ! test -d "$PROJECT_DIR/log"; then mkdir -p "$PROJECT_DIR/log" ; fi) &&\
(if ! test -d "$PROJECT_DIR/tmp"; then mkdir -p "$PROJECT_DIR/tmp/pid" ; fi)
RUN apk update && apk upgrade && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    apk add --no-cache \
      chromium@edge \
      harfbuzz@edge \
      nss@edge
RUN addgroup -S pptruser && adduser -S -g pptruser pptruser \
    && mkdir -p /home/pptruser/Downloads \
    && chown -R pptruser:pptruser /home/pptruser \
    && chown -R pptruser:pptruser /app

WORKDIR $PROJECT_DIR
COPY package.json package-lock.json ./
RUN npm set progress=false && npm i
RUN rm -rf  ./node_modules/puppeteer/.local-chromium/
ENV PROJECT_NAME=screenshoter
COPY docker/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh && \
ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat
ADD . .
RUN rm -rf docker && rm -rf .git rm -rf /var/cache/apk/*

USER pptruser
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["start"]
EXPOSE 6116
VOLUME ["$PROJECT_DIR", "$PROJECT_DIR/log", "$PROJECT_DIR/tmp"]
