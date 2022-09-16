FROM golang:1.17.0 as build

WORKDIR /app

RUN go env -w GO111MODULE=auto
RUN go get github.com/thedevsaddam/renderer/...

COPY main.go .

RUN go build main.go

FROM alpine

WORKDIR /app
EXPOSE 8080

COPY --from=build ./app/main ./
COPY ./tpl ./tpl

CMD ["./main"]