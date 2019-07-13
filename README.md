# client-server-worker

### Overwiew

- Endpoint written in _python3_;
- API written in _ruby_;
- Worker written in _go_;

## Usage

### With docker-compose

`$ git clone https://github.com/ArkadiuszKolodynski/client-server-worker.git`<br>
`$ cd client-server-worker`<br>
`$ docker-compose up -d`<br>
`$ python3 client/client.py`

### Without docker

`$ git clone https://github.com/ArkadiuszKolodynski/client-server-worker.git`<br>
`$ cd client-server-worker`<br>
`$ go build -o worker/worker.o worker/worker.go`<br>
`$ ruby server/server.rb`<br>
`$ python3 client/client.py`

<hr>Requests log will be stored in _./logs_ directory<hr>

### End
