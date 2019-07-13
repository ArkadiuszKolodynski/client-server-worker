import socket
import sys

HOST = "127.0.0.1"
PORT = (
    int(sys.argv[sys.argv.index("--port") + 1])
    if sys.argv.index("--port") and sys.argv[sys.argv.index("--port") + 1]
    else 3000
)


class Client:
    def __init__(self, n, expressions):
        self.n = n
        self.expressions = expressions

    def execute(self):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.connect((HOST, PORT))
            s.sendall(bytearray(n, "utf-8"))
            for e in expressions:
                s.sendall(bytearray(e, "utf-8"))
            data = s.recv(8192)

        print("\nOutput:")
        print(data.decode("utf-8"))


def handleInputErrors(n):
    msg = "\nIvalid number of expressions!"
    try:
        try:
            temp = int(n)
        except ValueError as err:
            raise ValueError(msg)
        if temp <= 0:
            raise ValueError(msg)
    except ValueError as err:
        print(err)
        exit()


if __name__ == "__main__":
    n = input("Number of expressions to calculate: ") + "\n"

    handleInputErrors(n)

    expressions = []
    for i in range(int(n)):
        expressions.append(input("Expression: ") + "\n")

    client = Client(n, expressions)
    client.execute()
