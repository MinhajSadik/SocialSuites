# initial setup for go project similar like hootsuites
FROM golang:1.18-alpine as builder

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./
RUN go build -o /docker-gs-ping

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder /docker-gs-ping /docker-gs-ping
ENTRYPOINT [ "/docker-gs-ping" ]
