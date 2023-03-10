FROM golang:1.19 AS builder
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

WORKDIR /build
COPY . .
RUN go build -o httpserver .

FROM scratch
LABEL author="librant"
COPY --from=builder /build/httpserver /
EXPOSE 8080
ENTRYPOINT ["/httpserver"]