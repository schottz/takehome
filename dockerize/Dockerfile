FROM golang:latest

WORKDIR /dockerize

COPY . .

RUN echo $SERVER_CONFI > server.confi

RUN go mod init dockerize && \
    go mod tidy

CMD go run webserver.go