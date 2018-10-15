# vim:set ft=dockerfile:
FROM golang:1.9-alpine3.7
LABEL maintainer="hello@gsviec.com"

WORKDIR /go/src/github.com/gsviec
ADD . ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest
COPY docker-entrypoint.sh  /usr/local/bin/

RUN apk --no-cache add ca-certificates curl \
	&& chmod +x /usr/local/bin/docker-entrypoint.sh \
	&& ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat

WORKDIR /app/
COPY --from=0 /go/src/github.com/gsviec/app .

ENTRYPOINT ["docker-entrypoint.sh"]
CMD [start]
EXPOSE 8080


