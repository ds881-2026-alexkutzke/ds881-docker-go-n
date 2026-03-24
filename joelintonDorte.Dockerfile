# build
FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY go.mod ./
COPY . .
RUN go mod tidy
RUN go build -o calculadora-api ./...

# runtime
FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app/calculadora-api ./calculadora-api
EXPOSE 8080
USER 65532:65532
CMD ["./calculadora-api"]
