FROM golang:1.4

RUN apt-get update && \
    apt-get install -y librados-dev && \
    rm -rf /var/lib/apt/lists/*

ENV DISTRIBUTION_DIR /go/src/github.com/docker/distribution
ENV GOPATH $DISTRIBUTION_DIR/Godeps/_workspace:$GOPATH
ENV DOCKER_BUILDTAGS include_rados include_azure

WORKDIR $DISTRIBUTION_DIR
COPY . $DISTRIBUTION_DIR
RUN make PREFIX=/go clean binaries

VOLUME ["/var/lib/registry"]
EXPOSE 5000
ENTRYPOINT ["registry"]
CMD ["cmd/registry/config.yml"]
