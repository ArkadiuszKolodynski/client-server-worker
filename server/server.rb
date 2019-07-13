require "socket"

PORT = ARGV.index("--port") && ARGV[ARGV.index("--port")+1] ? ARGV[ARGV.index("--port")+1] : 3000
LOG_PATH = "logs"

class Server
    def executeJob(expression)
        starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        worker = IO.popen(["worker/worker.o", expression], mode="r")
        result = worker.gets
        ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        return result, starting, ending
    end

    def formatOutput(result, starting, ending)
        result + ", " + "%.3f" % (ending - starting).to_s + "\n"
    end

    def log(msg)
        unless Dir.exist?(LOG_PATH)
            Dir.mkdir(LOG_PATH)
        end
        open(LOG_PATH + "/requests.log", "a") do |f|
            begin
                f.puts(msg)
            end
        end
    end

    def spawnServer
        puts("Server is listening on #{PORT}...")
        Socket.tcp_server_loop(PORT) do |sock, client_addrinfo|
            Thread.new do
                begin                              
                    input = sock.recv(8192).split("\n", -1)[0...-1]
        
                    requestTime = Time.now
                    log("Request from " + client_addrinfo.ip_address + " at " + requestTime.to_s + ": " + input.to_s)
                    
                    output = ""
                    resultsArray = []
                    input.drop(1).each do |expression|
                        print expression
                        result, starting, ending = executeJob(expression)
                        resultsArray.push(result)
                        output += formatOutput(result, starting, ending)
                    end

                    respondTime = Time.now
                    log("Respond to " + client_addrinfo.ip_address + " at " + respondTime.to_s + ": " + resultsArray.to_s)
        
                    sock.puts(output)
                ensure
                    sock.close
                end
            end
        end
    end
end

Server.new.spawnServer
