FROM ubuntu:22.04

RUN apt-get update && apt-get install -y netcat bash

WORKDIR /app

COPY menger.sh .

RUN chmod +x menger.sh

CMD ["./menger.sh"]