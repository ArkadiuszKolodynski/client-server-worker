# client-server-worker

### Overwiew

- Endpoint written in _python3_;
- API written in _ruby_;
- Worker written in _go_;

## Usage

### With docker-compose

`$ git clone https://github.com/ArkadiuszKolodynski/client-server-worker.git`
`$ cd client-server-worker`
`$ docker-compose up -d`
`$ python3 client/client.py`

### Without docker

`$ git clone https://github.com/ArkadiuszKolodynski/client-server-worker.git`
`$ cd client-server-worker`
`$ go build -o worker/worker.o worker/worker.go`
`$ ruby server/server.rb`
`$ python3 client/client.py`

<hr>Requests log will be stored in `"./logs"` directory<hr>

###End
