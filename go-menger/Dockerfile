# ---- Builder ----
FROM golang:1.24-alpine AS builder

WORKDIR /app

# install git (บาง dependency ต้องใช้)
RUN apk add --no-cache git

# cache dependency
COPY go.mod go.sum ./
RUN go mod download

# copy source
COPY . .

# build static binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o go-menger .

# ---- Runner ----
FROM debian:12-slim

WORKDIR /app

COPY --from=builder /app/go-menger .

EXPOSE 8080

CMD ["./go-menger"]