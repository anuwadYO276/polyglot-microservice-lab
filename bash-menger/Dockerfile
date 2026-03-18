FROM alpine:3.19

WORKDIR /app

RUN apk add --no-cache bash netcat-openbsd

COPY menger.sh .

# 🔥 แก้ CRLF → LF
RUN sed -i 's/\r$//' menger.sh

RUN chmod +x menger.sh

CMD ["bash", "menger.sh"]