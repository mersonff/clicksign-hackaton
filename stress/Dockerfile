FROM golang:1.19

RUN go install github.com/tsenart/vegeta@latest

COPY targets.txt targets.txt
COPY attack.sh attack.sh

CMD ./attack.sh
