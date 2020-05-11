FROM golang:1.12-alpine AS build
LABEL maintainer "awsumco <awsumco@users.noreply.github.com>"


ENV CGO_ENABLED=0
ENV GOOS=linux

RUN \
  apk add --no-cache \
   git \
   bash \
   musl-dev && \
   git clone -b  v0.70.0 https://github.com/gohugoio/hugo.git /opt/gohugo/ && \
   cd /opt/gohugo/ && \
   go install -ldflags="-s -w"

FROM nginx:alpine
LABEL maintainer "awsumco <awsumco@users.noreply.github.com>"

RUN apk add --no-cache \
	bash 

COPY --from=build /go/bin/hugo /bin/hugo
COPY entrypoint.sh /etc/entrypoint.sh
COPY ./data/ /data/

RUN chmod +x /etc/entrypoint.sh

# EXPOSE  80

ENTRYPOINT [ "/etc/entrypoint.sh" ]
# CMD [ "--help" ]

