FROM golang:latest as build
MAINTAINER Ster "770378744@qq.com"
WORKDIR /go/src/helloworld
COPY ./src/helloworld /go/src/helloworld
RUN go build .

FROM golang:latest
COPY --from=build /go/src/helloworld /go/src/helloworld
EXPOSE 8080
ENTRYPOINT ["./helloworld"]

