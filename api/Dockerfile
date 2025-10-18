FROM golang:1.23-alpine AS builder

WORKDIR /app

COPY . .

RUN go mod init temp && \
    CGO_ENABLED=0 GOOS=linux go build -o main main.go

FROM scratch

COPY --from=builder /app/main /main

EXPOSE 8080

ENTRYPOINT ["/main"]
