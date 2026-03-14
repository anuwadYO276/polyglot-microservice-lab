FROM alpine:3.19

WORKDIR /app

RUN apk add --no-cache bash netcat-openbsd

COPY menger.sh .

RUN chmod +x menger.sh

CMD ["bash", "menger.sh"]