FROM alpine:latest
WORKDIR /home/ruby-server
RUN apk add --no-cache go musl-dev ruby
COPY server server
COPY worker worker
RUN go build -o worker/worker.o worker/worker.go
CMD ["ruby", "server/server.rb"]
